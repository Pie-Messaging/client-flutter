import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  filter: _LogFilter(),
  printer: _LogPrinter(),
  output: _LogOutput(),
  level: kReleaseMode ? Level.info : Level.verbose,
);

class _LogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => true;
}

class _LogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final lines = PrettyPrinter(methodCount: 0, noBoxingByDefault: true).log(event);
    return lines.map((line) {
      final now = DateTime.now();
      return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}.${now.millisecond.toString().padLeft(3, '0')} $line';
    }).toList();
  }
}

class _LogOutput extends LogOutput {
  late final IOSink _io;

  @override
  void init() {
    if (kReleaseMode) {
      _io = File('log.txt').openWrite();
    }
  }

  @override
  void output(OutputEvent event) {
    if (kReleaseMode) {
      _io.writeln(event.lines.join('\n'));
    } else {
      print(event.lines.join('\n'));
    }
  }

  @override
  void destroy() {
    if (kReleaseMode) {
      _io.flush();
      _io.close();
    }
  }
}
