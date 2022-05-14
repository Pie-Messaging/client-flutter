import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:pie/entities/account.dart';
import 'package:pie/entities/user.dart';
import 'package:pie/lib/address.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/id.dart';
import 'package:pie/lib/tracker.dart';
import 'package:pie/protobuf/core.pb.dart' as pb;

class RoutingTable {
  final trackerMap = <ID, Tracker>{};
  final trackerList = DoubleLinkedQueue<Tracker>();
  final trackerTree = TreeNode(0);

  RoutingTable();

  load() async {
    final results = await mainDB.query('tracker');
    for (final row in results) {
      final id = (row['id'] as Uint8List).toID();
      final addr = (jsonDecode(row['addr'] as String) as List).toAddr();
      final tracker = Tracker(id, addr);
      addTracker(tracker);
    }
  }

  addTracker(Tracker tracker) {
    trackerMap[tracker.id] = tracker;
    trackerList.addFirst(tracker);
    var node = trackerTree;
    for (int i = 0; i < idLen; i++) {
      if (node.children[tracker.id.b(i)] == null) {
        node.children[tracker.id.b(i)] = TreeNode(i + 1);
      }
      node = node.children[tracker.id.b(i)]!;
    }
    node.value = tracker;
  }

  List<Tracker> getNeighbors(ID id, int numVisiting, [Set<ID>? visitedSet]) {
    var visited = 0;
    final result = <Tracker>[];
    next(TreeNode? node) {
      if (node == null) return;
      if (node.value != null) {
        if (visitedSet == null || !visitedSet.contains(node.value!.id)) {
          result.add(node.value!);
          visitedSet?.add(node.value!.id);
        }
        visited++;
        if (visited == numVisiting) return;
      }
      next(node.children[id.b(node.depth)]);
      next(node.children[-id.b(node.depth) + 1]);
    }

    next(trackerTree);
    return result;
  }

  Future<User?> findUser(int ctx, ID id) async {
    final results = await findResource<User>(ctx, id, pb.ResourceType.USER, (resource) {
      if (resource.hasUser()) {
        final user = resource.user;
        if (user.id.toID() == id) {
          if (user.hasId() && user.hasName() && user.hasCertDer()) {
            return User(id)
              ..name = user.name
              ..email = user.email
              ..bio = user.bio
              ..hasAvatar = user.avatar.isNotEmpty
              ..avatarBytes = user.avatar.toUint8List()
              ..addr = user.addresses.toAddr()
              ..certDER = user.certDer.toUint8List();
          }
        }
      }
      return null;
    });
    return results.isEmpty ? null : results.first;
  }

  Future<User?> findUserForAddingContact(int ctx, ID id, String certHash) async {
    final results = await findResource<User>(ctx, id, pb.ResourceType.USER, (resource) {
      if (resource.hasUser()) {
        final user = resource.user;
        if (user.id.toID() == id) {
          final certDER = Uint8List.fromList(user.certDer);
          final resultPtr = malloc<Uint8>(userCertHashLen);
          hashBytes(certDER, resultPtr, userCertHashLen);
          final certHashResult = resultPtr.asTypedList(userCertHashLen).toHexStr();
          malloc.free(resultPtr);
          if (certHashResult == certHash) {
            return User(id)
              ..name = user.name
              ..email = user.email
              ..bio = user.bio
              ..hasAvatar = user.avatar.isNotEmpty
              ..avatarBytes = user.avatar.toUint8List()
              ..account = providers.read(currAccountPro)!
              ..state = UserState.selfAddingContact
              ..addr = user.addresses.toAddr()
              ..certDER = certDER;
          }
        }
      }
      return null;
    });
    return results.isEmpty ? null : results.first;
  }

  Future putUser(int ctx, Account account) async {
    final neighbors = getNeighbors(account.id, metaDataRedundancy);
    if (neighbors.isEmpty) {
      throw Exception('no neighbors');
    }
    final pbUser = pb.User(
      id: account.id.toIntList(),
      name: account.name,
      email: account.email,
      bio: account.bio,
      avatar: account.hasAvatar ? await File(account.avatarPath).readAsBytes() : null,
      certDer: account.certDER,
      addresses: account.addr.keys,
    );
    await Future.wait(neighbors.map((tracker) async {
      await tracker.putResource(ctx, account.id, pb.ResourceType.USER, pb.Resource()..user = pbUser);
    }), eagerError: true);
  }

  Future<List<R>> findResource<R>(int ctx, ID id, pb.ResourceType type, R? Function(pb.Resource) convertor) async {
    final results = <R>[];
    final visited = <ID>{};
    while (true) {
      final neighbors = getNeighbors(id, alpha, visited);
      if (neighbors.isEmpty) {
        return results;
      }
      await Future.wait(neighbors.map((tracker) async {
        final response = await tracker.findResource(ctx, id, type);
        if (response.hasResource()) {
          final resource = convertor(response.resource);
          if (resource != null) {
            results.add(resource);
          }
        } else {
          for (final tracker in response.candidateTrackers) {
            addTracker(Tracker(tracker.id.toID(), tracker.addr.toAddr()));
          }
        }
      }), eagerError: true);
      // TODO: verify
      if (results.isNotEmpty) {
        return results;
      }
    }
  }

  Future putResource(int ctx, ID id, pb.ResourceType type, pb.Resource resource) async {
    await findTracker(ctx, id);
    final neighbors = getNeighbors(id, metaDataRedundancy);
    if (neighbors.isEmpty) {
      throw Exception('no neighbors');
    }
    await Future.wait(neighbors.map((tracker) async {
      await tracker.putResource(ctx, id, type, resource);
    }), eagerError: true);
  }

  Future<Addr> getAddr(int ctx) async {
    final addrList = Addr();
    final trackers = trackerList.take(alpha);
    await Future.wait(trackers.map((tracker) async {
      final addr = await tracker.getAddr(ctx);
      addrList.addAll(addr.toAddr());
    }), eagerError: true);
    return addrList;
  }

  Future findTracker(int ctx, ID id) async {
    final visited = <ID>{};
    while (true) {
      final neighbors = getNeighbors(id, alpha, visited);
      if (neighbors.isEmpty) {
        return;
      }
      await Future.wait(neighbors.map((tracker) async {
        final response = await tracker.findTracker(ctx, id);
        for (final tracker in response.candidates) {
          addTracker(Tracker(tracker.id.toID(), tracker.addr.toAddr()));
        }
      }), eagerError: true);
    }
  }
}

class TreeNode {
  final int depth;
  Tracker? value;
  final List<TreeNode?> children = [null, null];

  TreeNode(this.depth);
}
