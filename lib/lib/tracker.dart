import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:pie/core/generated_core_bindings.dart';
import 'package:pie/lib/address.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/ffi.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/id.dart';
import 'package:pie/lib/log.dart';
import 'package:pie/net/net.dart';
import 'package:pie/protobuf/core.pb.dart' as pb;

const numTracker = 1;

class Tracker {
  final ID id;
  final Addr addr;
  Session? session;
  var loadingSession = false;
  final loadSession = Completer();

  Tracker(this.id, this.addr);

  @override
  toString() => 'Tracker($id, $addr)';

  Future<Session> connect(int ctx) async {
    final recvPort = ReceivePort();
    final errPort = ReceivePort();
    Isolate.spawn(_connect, SpawnArg(this, ctx, recvPort.sendPort), onError: errPort.sendPort);
    final completer = Completer<Session>();
    recvPort.listen((s) {
      recvPort.close();
      errPort.close();
      final sess = Session(s);
      session = sess;
      completer.complete(sess);
      logger.d('connected to tracker: $this');
    });
    errPort.listen((error) {
      recvPort.close();
      errPort.close();
      completer.completeError(error);
    });
    return await completer.future;
  }

  static _connect(SpawnArg<Tracker, int> arg) {
    final addr = arg.obj.addr.keys.first;
    final addrDataPtr = addr.toNativeUtf8();
    final addrPtr = malloc<GoString>()
      ..ref.p = addrDataPtr.cast<Int8>()
      ..ref.n = addr.length;
    final idDataPtr = malloc<Uint8>(idLen)..asTypedList(idLen).setAll(0, arg.obj.id);
    final idPtr = malloc<GoSlice>()
      ..ref.data = idDataPtr.cast<Void>()
      ..ref.len = idLen
      ..ref.cap = idLen;
    final result = core.ConnectTracker(arg.arg, addrPtr.ref, idPtr.ref);
    final session = result.r0;
    final err = result.r1;
    malloc.free(idPtr);
    malloc.free(idDataPtr);
    malloc.free(addrPtr);
    malloc.free(addrDataPtr);
    if (err != Error.noErr.index) logger.d('Failed to connect to tracker: $addr');
    checkErr(err);
    arg.sendPort!.send(session);
  }

  ensureSession(int ctx) async {
    if (loadingSession) {
      await loadSession.future;
      return;
    }
    loadingSession = true;
    session ?? await connect(ctx);
    loadSession.complete();
  }

  Future<pb.FindResourceRes> findResource(int ctx, ID id, pb.ResourceType type) async {
    await ensureSession(ctx);
    final stream = await session!.openStream();
    await stream.sendMessage(
      pb.NetMessage(
        findResourceReq: pb.FindResourceReq()
          ..id = id.toIntList()
          ..type = type,
      ),
      sendMsgTimeout,
    );
    final response = await stream.recvMessage(recvResTimeout);
    stream.close();
    return response.ensureFindResourceRes();
  }

  Future putResource(int ctx, ID id, pb.ResourceType type, pb.Resource resource) async {
    await ensureSession(ctx);
    final stream = await session!.openStream();
    await stream.sendMessage(
      pb.NetMessage(
        putResourceReq: pb.PutResourceReq()
          ..type = type
          ..resource = resource,
      ),
      sendMsgTimeout,
    );
    await stream.recvMessage(recvResTimeout);
    stream.close();
  }

  Future<pb.FindTrackerRes> findTracker(int ctx, ID id) async {
    await ensureSession(ctx);
    final stream = await session!.openStream();
    await stream.sendMessage(
      pb.NetMessage(
        findTrackerReq: pb.FindTrackerReq()..id = id.toIntList(),
      ),
      sendMsgTimeout,
    );
    final response = await stream.recvMessage(recvResTimeout);
    stream.close();
    return response.ensureFindTrackerRes();
  }

  Future<List<String>> getAddr(int ctx) async {
    await ensureSession(ctx);
    final stream = await session!.openStream();
    await stream.sendMessage(
      pb.NetMessage(
        getAddrReq: pb.GetAddrReq(),
      ),
      sendMsgTimeout,
    );
    final response = await stream.recvMessage(recvResTimeout);
    stream.close();
    return response.ensureGetAddrRes().addresses;
  }
}
