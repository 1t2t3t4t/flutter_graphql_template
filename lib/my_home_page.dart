import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql_template/counter_detail_page.dart';
import 'package:flutter_graphql_template/graphql/client/graphql_client.dart';
import 'package:flutter_graphql_template/graphql/graphql_generated/graphql.generated.dart';
import 'package:flutter_graphql_template/utils/app_router.dart';
import 'package:flutter_graphql_template/utils/mvp/presenter.dart';
import 'package:flutter_graphql_template/utils/mvp/view.dart';
import 'package:graphql/client.dart';
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
  List<String> _countryList = [];

  MyHomePageState(this._router);

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    final gqlClient = GraphqlClientWrapperImpl(
        HttpLink("https://countries.trevorblades.com"));
    final query = CountriesQuery();
    final res = await gqlClient.query(query);
    final countries = res.data?.countries;
    if (countries != null) {
      setState(() {
        _countryList = countries.map((c) => c.name).toList();
      });
    }
  }

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
                onPressed: tapGoToDetail, child: Text("Go to detail page")),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _countryList.length,
                itemBuilder: (context, index) {
                  return Text(_countryList[index]);
                },
              ),
            ))
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
