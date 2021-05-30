class Either<TLeft, TRight> {
  final TLeft? _left;
  final TRight? _right;

  Either.left(this._left) : _right = null;
  Either.right(this._right) : _left = null;

  bool isLeft() => _left != null;
  bool isRight() => _right != null;

  TLeft asLeft() {
    assert(_left != null, "Left cannot be null");
    return _left!;
  }

  TRight asRight() {
    assert(_right != null, "Left cannot be null");
    return _right!;
  }
}
