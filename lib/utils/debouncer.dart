import 'dart:async';

typedef void _Callback<T>(T value);

class Debouncer<T> {
  Timer? _timer;
  final Duration duration;
  final _Callback<T> callback;

  Debouncer(this.duration, this.callback);

  void set(T value) {
    _timer?.cancel();
    _timer = Timer(duration, () => callback(value));
  }

  void cancel() {
    _timer?.cancel();
  }
}
