import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql_template/counter_detail_page.dart';
import 'package:flutter_graphql_template/graphql/client/graphql_client.dart';
import 'package:flutter_graphql_template/graphql/graphql_generated/graphql.generated.dart';
import 'package:flutter_graphql_template/utils/app_router.dart';
import 'package:graphql/client.dart';
import 'package:injector/injector.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

enum MyHomePageEvent { fetchCountry, increase }

enum MyHomePageStatus { init, normal }

class HomePageState extends Equatable {
  final int counter;
  final List<String> countries;

  const HomePageState(this.counter, this.countries);

  @override
  List<Object?> get props => [counter];
}

class MyHomePageBloc extends Bloc<MyHomePageEvent, HomePageState> {
  MyHomePageBloc() : super(const HomePageState(0, []));

  @override
  Stream<HomePageState> mapEventToState(MyHomePageEvent event) async* {
    switch (event) {
      case MyHomePageEvent.increase:
        yield HomePageState(state.counter + 1, state.countries);
        break;
      case MyHomePageEvent.fetchCountry:
        final countriesList = await _fetchCountries();
        yield HomePageState(state.counter, countriesList);
    }
  }

  Future<List<String>> _fetchCountries() async {
    final gqlClient = GraphqlClientWrapperImpl(
        HttpLink("https://countries.trevorblades.com"));
    final query = CountriesQuery();
    final res = await gqlClient.query(query);
    final countries = res.data?.countries;
    return countries?.map((c) => c.name).toList() ?? [];
  }
}

class MyHomePageState extends State<MyHomePage> {
  late MyHomePageBloc bloc;
  late CustomRouter _router;

  MyHomePageState() {
    _router = Injector.appInstance.get<CustomRouter>();
    bloc = MyHomePageBloc()..add(MyHomePageEvent.fetchCountry);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomePageState>(
        initialData: bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot) {
          final val = snapshot.data;
          if (val == null) {
            return Container();
          }
          return Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('You have pushed the button this many times:'),
                  Text(
                    '${val.counter}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextButton(
                      onPressed: () => _router.push(
                          CounterDetailPage(CounterDetailParam(val.counter)),
                          context),
                      child: const Text("Go to detail page")),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: val.countries.length,
                      itemBuilder: (context, index) {
                        return Text(val.countries[index]);
                      },
                    ),
                  ))
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => bloc.add(MyHomePageEvent.increase),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        });
  }
}
