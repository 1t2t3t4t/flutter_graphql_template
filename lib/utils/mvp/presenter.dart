import 'package:flutter_graphql_template/utils/mvp/view.dart';

abstract class Presenter<TView extends View> {
  late TView view;

  void bindView(TView view) {
    this.view = view;
  }
}
