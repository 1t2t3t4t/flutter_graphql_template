import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql_template/dependency_injection/assembly.dart';
import 'package:flutter_graphql_template/utils/mvp/presenter.dart';
import 'package:flutter_graphql_template/utils/mvp/view.dart';
import 'package:injector/injector.dart';

class CounterDetailAssembly extends Assembly {
  @override
  void register(Injector i) {
    i.registerDependency<CounterDetailPagePresenter>(
        () => CounterDetailPagePresenter());
    i.registerDependency<CounterDetailPageState>(() {
      final presenter = i.get<CounterDetailPagePresenter>();
      final view = CounterDetailPageState();
      return boundModule(presenter, view);
    });
  }
}

class CounterDetailParam {
  final int count;

  CounterDetailParam(this.count);
}

class CounterDetailPage extends StatefulWidget {
  final CounterDetailParam param;

  CounterDetailPage(this.param);

  @override
  State createState() => Injector.appInstance.get<CounterDetailPageState>();
}

class CounterDetailPagePresenter extends Presenter<CounterDetailPageState> {
  String get countDetail {
    return "You have pressed counter this amount ${view.param.count}";
  }
}

class CounterDetailPageState extends State<CounterDetailPage>
    with ViewWithParam<CounterDetailParam, CounterDetailPagePresenter> {
  @override
  CounterDetailParam get param {
    return widget.param;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Some title")),
      body: Center(
        child: Text(presenter.countDetail),
      ),
    );
  }
}
