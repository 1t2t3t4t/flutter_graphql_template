import 'dart:async';

abstract class ObservableValue<T> {
  T get currentValue;
  Stream<T> get stream;
}

class BroadcastableValue<T> implements ObservableValue<T> {
  final StreamController<T> _streamController = StreamController.broadcast();

  T _currentValue;

  @override
  T get currentValue {
    return _currentValue;
  }

  set currentValue(T newValue) {
    _currentValue = newValue;
    _streamController.add(newValue);
  }

  BroadcastableValue(this._currentValue);

  @override
  Stream<T> get stream => _streamController.stream;

  void notify() => _streamController.add(_currentValue);

  Future close() => _streamController.close();
}
