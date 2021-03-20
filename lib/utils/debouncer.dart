import 'dart:async';

/// Boilerplate class to prevent multiple calls at once
class Debouncer {
  final Duration delay;
  Timer _timer;

  Debouncer({this.delay = const Duration(milliseconds: 300)});

  call(Function action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
