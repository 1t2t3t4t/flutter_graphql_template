import 'package:flutter_graphql_template/utils/type/either.dart';
import 'package:injector/injector.dart';

abstract class Assembly {
  void register(Injector i);
}

mixin AssemblyContainer {
  List<Either<Assembly, AssemblyContainer>> get assemblies;
}

abstract class Assembler with AssemblyContainer {
  void register(Injector i) {
    _register(i, assemblies);
  }

  void _register(Injector i, List<Either<Assembly, AssemblyContainer>> a) {
    for (final assembly in assemblies) {
      if (assembly.isLeft()) {
        assembly.asLeft().register(i);
      } else {
        _register(i, assembly.asRight().assemblies);
      }
    }
  }
}
