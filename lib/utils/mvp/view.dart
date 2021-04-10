import 'package:flutter/widgets.dart';
import 'package:flutter_graphql_template/utils/mvp/presenter.dart';

mixin View {

}

mixin ViewWithParam<T> implements View {
  T get param;
}
