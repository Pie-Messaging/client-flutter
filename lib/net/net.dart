import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:pie/core/generated_core_bindings.dart';
import 'package:pie/entities/user.dart';
import 'package:pie/lib/address.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/errors.dart';
import 'package:pie/lib/ffi.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/log.dart';
import 'package:pie/protobuf/core.pb.dart' as pb;

enum Error {
  noErr,
  unknown,
  timedOut,
  closed,
  msgTooLong,
  canceled,
}

enum SessionErr {
  noReason,
  notFound,
}

class Session {
  final int sessionPtr;
  late final User? user;
  final Addr? addr;
  final List<QuicStream> pendingStreams = [];

  Session(this.sessionPtr, {this.addr});

  Future<QuicStream> acceptStream(int ctx) async {
    final recvPort = ReceivePort();
    final errPort = ReceivePort();
    Isolate.spawn(_acceptStream, SpawnArg(null, _SessionAcceptStream(ctx, sessionPtr), recvPort.sendPort), onError: errPort.sendPort);
    final recvStream = recvPort.asBroadcastStream();
    // final SendPort sendPort = await recvStream.first;
    final completer = Completer<QuicStream>();
    late StreamSubscription recvPortSubscription;
    recvPortSubscription = recvStream.listen((stream) {
      recvPortSubscription.cancel();
      errPort.close();
      stream = stream as QuicStream;
      completer.complete(
        stream
          ..session = this
          .._recvStream = recvStream,
      );
    });
    errPort.listen((error) {
      recvPort.close();
      errPort.close();
      completer.completeError(error);
    });
    return await completer.future;
  }

  static _acceptStream(SpawnArg<void, _SessionAcceptStream> arg) async {
    final recvPort = ReceivePort();
    // arg.sendPort!.send(recvPort.sendPort);
    final recvBufDataPtr = malloc<Uint8>(maxMessageLen);
    final recvBufPtr = malloc<GoSlice>()
      ..ref.data = recvBufDataPtr.cast<Void>()
      ..ref.len = maxMessageLen
      ..ref.cap = maxMessageLen;
    try {
      late SessionAcceptStream_return result;
      // use loop to avoid blocking on ffi calls all the time or Flutter hot reload and hot restart will stuck
      while (true) {
        result = core.SessionAcceptStream(arg.arg.ctx, arg.arg.sessionPtr, recvBufPtr.ref);
        final err = result.r2;
        if (checkErr(err, Error.timedOut)) break;
      }
      final streamPtr = result.r0;
      final streamID = result.r1;
      arg.sendPort!.send(QuicStream(streamPtr, streamID, recvPort.sendPort));
      await for (final data in recvPort) {
        if (data[0] < 0) return;
        arg.sendPort!.send(Pointer.fromAddress(data[0] + recvBufDataPtr.address).cast<Uint8>().asTypedList(data[1] - data[0]));
      }
    } catch (_) {
      rethrow;
    } finally {
      malloc.free(recvBufPtr);
      malloc.free(recvBufDataPtr);
    }
  }

  Future<QuicStream> openStream() async {
    final recvPort = ReceivePort();
    final errPort = ReceivePort();
    Isolate.spawn(_openStream, SpawnArg(this, null, recvPort.sendPort), onError: errPort.sendPort);
    final recvStream = recvPort.asBroadcastStream();
    late StreamSubscription recvPortSubscription;
    final completer = Completer<QuicStream>();
    recvPortSubscription = recvStream.listen((stream) {
      recvPortSubscription.cancel();
      errPort.close();
      stream = stream as QuicStream;
      completer.complete(
        stream
          ..session = this
          .._recvStream = recvStream,
      );
    });
    errPort.listen((error) {
      recvPort.close();
      errPort.close();
      completer.completeError(error);
    });
    return await completer.future;
  }

  static _openStream(SpawnArg<Session, void> arg) async {
    final recvPort = ReceivePort();
    final recvBufDataPtr = malloc<Uint8>(maxMessageLen);
    final recvBufPtr = malloc<GoSlice>()
      ..ref.data = recvBufDataPtr.cast<Void>()
      ..ref.len = maxMessageLen
      ..ref.cap = maxMessageLen;
    try {
      final result = core.SessionOpenStream(arg.obj.sessionPtr, recvBufPtr.ref);
      final streamPtr = result.r0;
      final streamID = result.r1;
      final err = result.r2;
      checkErr(err);
      arg.sendPort!.send(QuicStream(streamPtr, streamID, recvPort.sendPort));
      await for (final data in recvPort) {
        if (data[0] < 0) return;
        arg.sendPort!.send(Pointer.fromAddress(data[0] + recvBufDataPtr.address).cast<Uint8>().asTypedList(data[1] - data[0]));
      }
    } catch (_) {
      rethrow;
    } finally {
      malloc.free(recvBufPtr);
      malloc.free(recvBufDataPtr);
    }
  }

  Future<QuicStream> sendMessage(pb.NetMessage message, int timeout) async {
    final stream = await openStream();
    await stream.sendMessage(message, timeout);
    return stream;
  }

  close([int? error]) async {
    error ??= SessionErr.noReason.index;
    await compute(_close, SpawnArg(this, error));
  }

  static _close(SpawnArg<Session, int> arg) async {
    core.CloseSession(arg.obj.sessionPtr, arg.arg);
  }
}

class QuicStream {
  late final Session session;
  final int streamPtr;
  final int streamID;
  final SendPort _sendPort;
  late final Stream _recvStream;

  QuicStream(this.streamPtr, this.streamID, this._sendPort);

  Future sendMessage(pb.NetMessage message, int timeout) async {
    final buffer = message.writeToBuffer();
    await compute(_sendData, SpawnArg(null, _StreamSendData(streamPtr, buffer, timeout), _sendPort));
    logger.d('sent message: $message');
  }

  Future sendData(List<int> data, int timeout) async {
    await compute(_sendData, SpawnArg(null, _StreamSendData(streamPtr, data, timeout), _sendPort));
  }

  static _sendData(SpawnArg<void, _StreamSendData> arg) {
    // TODO: use while loop to avoid frequent malloc/free
    final messageBufPtr = malloc<Uint8>(arg.arg.data.length)..asTypedList(arg.arg.data.length).setAll(0, arg.arg.data);
    final messagePtr = malloc<GoSlice>()
      ..ref.data = messageBufPtr.cast<Void>()
      ..ref.len = arg.arg.data.length
      ..ref.cap = arg.arg.data.length;
    try {
      final err = core.StreamSendData(arg.arg.streamPtr, messagePtr.ref, arg.arg.timeout);
      checkErr(err);
    } catch (_) {
      rethrow;
    } finally {
      malloc.free(messagePtr);
      malloc.free(messageBufPtr);
    }
  }

  Future<pb.NetMessage> recvMessage(int timeout) async {
    final data = await recvData(timeout);
    final message = pb.NetMessage.fromBuffer(data);
    logger.d('received message: $message');
    return message;
  }

  Future<Uint8List> recvData(int timeout) async {
    final data = await compute(_recvData, SpawnArg(null, _StreamRecvData(streamPtr, timeout)));
    _sendPort.send(data);
    return await _recvStream.first;
  }

  static List<int> _recvData(SpawnArg<void, _StreamRecvData> arg) {
    final start = DateTime.now();
    late StreamRecvData_return result;
    // use loop to avoid blocking on ffi calls all the time or Flutter hot reload and hot restart will stuck
    while (arg.arg.timeout == 0 || DateTime.now().difference(start).inMilliseconds < arg.arg.timeout) {
      result = core.StreamRecvData(arg.arg.stream);
      final err = result.r2;
      if (checkErr(err, Error.timedOut)) break;
    }
    return [result.r0, result.r1];
  }

  Future close() async {
    await compute(_close, SpawnArg(null, streamPtr));
    _sendPort.send([-1, -1]);
  }

  static _close(SpawnArg<void, int> arg) async {
    core.CloseStream(arg.arg);
  }
}

class _SessionAcceptStream {
  final int ctx;
  final int sessionPtr;

  _SessionAcceptStream(this.ctx, this.sessionPtr);
}

class _StreamSendData {
  final int streamPtr;
  final List<int> data;
  final int timeout;

  _StreamSendData(this.streamPtr, this.data, this.timeout);
}

class _StreamRecvData {
  final int stream;
  final int timeout;

  _StreamRecvData(this.stream, this.timeout);
}

bool checkErr(int error, [Error? ignore]) {
  final err = Error.values[error];
  if (err == ignore) {
    return false;
  }
  switch (err) {
    case Error.noErr:
      return true;
    case Error.unknown:
      throw UnknownException();
    case Error.timedOut:
      throw TimedOutException();
    case Error.closed:
      throw ClosedException();
    case Error.msgTooLong:
      throw MsgTooLongException();
    case Error.canceled:
      throw CanceledException();
  }
}
