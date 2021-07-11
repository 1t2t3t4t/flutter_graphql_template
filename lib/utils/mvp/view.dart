mixin View<T> {
  late T presenter;
}

mixin ViewWithParam<T, P> implements View<P> {
  @override
  late P presenter;
  T get param;
}
