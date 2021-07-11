import 'dart:async';

typedef _Callback<T> = void Function(T value);

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
