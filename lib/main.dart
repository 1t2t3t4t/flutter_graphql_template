import 'package:flutter/material.dart';
import 'package:flutter_graphql_template/counter_detail_page.dart';
import 'package:flutter_graphql_template/dependency_injection/assembly.dart';
import 'package:flutter_graphql_template/utils/app_router.dart';
import 'package:flutter_graphql_template/utils/type/either.dart';
import 'package:injector/injector.dart';

import 'my_home_page.dart';

class AppAssembler extends Assembler {
  @override
  List<Either<Assembly, AssemblyContainer>> get assemblies => [
    Either.left(MyHomeAssembly()),
    Either.left(CounterDetailAssembly()),
    Either.left(CommonAssembly())
  ];
}

class CommonAssembly extends Assembly {

  @override
  void register(Injector i) {
    i.registerDependency<CustomRouter>(() => MainAppRouter());
  }
}

void main() {
  final appAssembly = AppAssembler();
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

