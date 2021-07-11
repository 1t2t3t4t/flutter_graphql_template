import 'package:flutter_graphql_template/utils/mvp/view.dart';

abstract class Presenter<TView extends View> {
  late TView view;

  // ignore: use_setters_to_change_properties
  void bindView(TView view) {
    this.view = view;
  }
}
