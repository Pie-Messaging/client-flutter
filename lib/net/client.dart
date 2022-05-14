import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:pie/core/generated_core_bindings.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/ffi.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/id.dart';
import 'package:pie/net/net.dart';

class Client {
  final ID accountID;
  late final int cert;

  Client(this.accountID, this.cert);

  Future<Session> connectServer(int ctx, String serverAddr, Uint8List serverCertDER) async {
    final recvPort = ReceivePort();
    final errPort = ReceivePort();
    await Isolate.spawn(_connectServer, SpawnArg(this, _ConnectServer(ctx, serverAddr, serverCertDER), recvPort.sendPort), onError: errPort.sendPort);
    final completer = Completer<Session>();
    recvPort.listen((session) {
      recvPort.close();
      errPort.close();
      completer.complete(Session(session));
    });
    errPort.listen((error) {
      recvPort.close();
      errPort.close();
      completer.completeError(error);
    });
    return await completer.future;
  }

  static _connectServer(SpawnArg<Client, _ConnectServer> arg) {
    final clientIDDataPtr = malloc<Uint8>(idLen)..asTypedList(idLen).setAll(0, arg.obj.accountID.l);
    final clientIDPtr = malloc<GoSlice>()
      ..ref.data = clientIDDataPtr.cast<Void>()
      ..ref.len = idLen
      ..ref.cap = idLen;
    final serverAddrDataPtr = arg.arg.serverAddr.toNativeUtf8();
    final serverAddrPtr = malloc<GoString>()
      ..ref.p = serverAddrDataPtr.cast<Int8>()
      ..ref.n = arg.arg.serverAddr.length;
    final serverCertDataPtr = malloc<Uint8>(arg.arg.serverCertDER.length)..asTypedList(arg.arg.serverCertDER.length).setAll(0, arg.arg.serverCertDER);
    final serverCertPtr = malloc<GoSlice>()
      ..ref.data = serverCertDataPtr.cast<Void>()
      ..ref.len = arg.arg.serverCertDER.length
      ..ref.cap = arg.arg.serverCertDER.length;
    final result = core.ConnectServer(arg.arg.ctx, clientIDPtr.ref, arg.obj.cert, serverAddrPtr.ref, serverCertPtr.ref);
    malloc.free(serverCertPtr);
    malloc.free(serverCertDataPtr);
    malloc.free(serverAddrPtr);
    malloc.free(serverAddrDataPtr);
    final session = result.r0;
    final err = result.r1;
    checkErr(err);
    arg.sendPort!.send(session);
  }
}

class _ConnectServer {
  final int ctx;
  final String serverAddr;
  final Uint8List serverCertDER;

  _ConnectServer(this.ctx, this.serverAddr, this.serverCertDER);
}
