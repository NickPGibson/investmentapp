import 'package:flutter/foundation.dart';

abstract interface class Logger {
  void error(Object error, StackTrace stackTrace);
}

class DebugLogger implements Logger {
  @override
  void error(Object error, StackTrace stackTrace) {
    debugPrint('Error: $error\n$stackTrace');
  }
}
