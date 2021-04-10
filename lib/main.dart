import 'package:flutter/material.dart';
import 'package:flutter_graphql_template/dependency_injection/assembly.dart';
import 'package:flutter_graphql_template/utils/type/either.dart';
import 'package:injector/injector.dart';

class AppAssembly extends CompositeAssembly {
  @override
  List<Either<Assembly, AssemblyContainer>> get assemblies =>
      [Either.left(MyHomeAssembly())];
}

class MyHomeAssembly implements Assembly {
  @override
  void register(Injector i) {
    i.registerDependency<StupidCounter>(() => StupidCounter());
    i.registerDependency<_MyHomePageState>(() => _MyHomePageState(i.get()));
  }
}

void main() {
  final appAssembly = AppAssembly();
  appAssembly.register(Injector.appInstance);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() =>
      Injector.appInstance.get<_MyHomePageState>();
}

class StupidCounter {
  int counter = 0;
}

class _MyHomePageState extends State<MyHomePage> {
  final StupidCounter _counter;

  _MyHomePageState(this._counter);

  void _incrementCounter() {
    setState(() {
      _counter.counter++;
    });
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
              '${_counter.counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
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
