import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql_template/counter_detail_page.dart';
import 'package:flutter_graphql_template/utils/app_router.dart';
import 'package:flutter_graphql_template/utils/mvp/presenter.dart';
import 'package:flutter_graphql_template/utils/mvp/view.dart';
import 'package:injector/injector.dart';

import 'dependency_injection/assembly.dart';

class MyHomeAssembly extends Assembly {
  @override
  void register(Injector i) {
    i.registerDependency<MyHomePagePresenter>(() => MyHomePagePresenter());
    i.registerDependency<MyHomePageState>(() {
      final presenter = i.get<MyHomePagePresenter>();
      final view = MyHomePageState(i.get());
      return boundModule(presenter, view);
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  MyHomePageState createState() => Injector.appInstance.get<MyHomePageState>();
}

class MyHomePagePresenter extends Presenter<MyHomePageState> {
  int _counter = 0;
  int get counter => _counter;

  void increase() {
    _counter++;
  }
}

class MyHomePageState extends State<MyHomePage> with View<MyHomePagePresenter> {
  final CustomRouter _router;

  MyHomePageState(this._router);

  void _incrementCounter() {
    setState(() {
      presenter.increase();
    });
  }

  void tapGoToDetail() {
    final param = CounterDetailParam(presenter.counter);
    _router.push(CounterDetailPage(param), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Text(
              '${presenter.counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
                onPressed: tapGoToDetail, child: Text("Go to detail page"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
