mixin View<T> {
  late T presenter;
}

mixin ViewWithParam<T, P> implements View<P> {
  late P presenter;
  T get param;
}
