import 'package:flutter/foundation.dart';
import 'dart:async';

class Debouncer {
  final int? msDelay;
  Timer? _timer;
  Debouncer({this.msDelay});
  run(VoidCallback action) {
    if (_timer != null && (_timer?.isActive ?? false)) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: msDelay ?? 500), action);
  }
}
