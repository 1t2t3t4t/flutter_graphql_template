// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'graphql.generated.graphql.g.dart';

mixin CountryFragmentMixin {
  String name;
  List<CountryFragmentMixin$Language> languages;
}

@JsonSerializable(explicitToJson: true)
class Countries$Query$Country with EquatableMixin, CountryFragmentMixin {
  Countries$Query$Country();

  factory Countries$Query$Country.fromJson(Map<String, dynamic> json) =>
      _$Countries$Query$CountryFromJson(json);

  @override
  List<Object> get props => [name, languages];
  Map<String, dynamic> toJson() => _$Countries$Query$CountryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Countries$Query with EquatableMixin {
  Countries$Query();

  factory Countries$Query.fromJson(Map<String, dynamic> json) =>
      _$Countries$QueryFromJson(json);

  List<Countries$Query$Country> countries;

  @override
  List<Object> get props => [countries];
  Map<String, dynamic> toJson() => _$Countries$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CountryFragmentMixin$Language with EquatableMixin {
  CountryFragmentMixin$Language();

  factory CountryFragmentMixin$Language.fromJson(Map<String, dynamic> json) =>
      _$CountryFragmentMixin$LanguageFromJson(json);

  String code;

  String name;

  @override
  List<Object> get props => [code, name];
  Map<String, dynamic> toJson() => _$CountryFragmentMixin$LanguageToJson(this);
}

class CountriesQuery extends GraphQLQuery<Countries$Query, JsonSerializable> {
  CountriesQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'Countries'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'countries'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'CountryFragment'), directives: [])
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'CountryFragment'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'Country'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'name'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'languages'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'code'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'Countries';

  @override
  List<Object> get props => [document, operationName];
  @override
  Countries$Query parse(Map<String, dynamic> json) =>
      Countries$Query.fromJson(json);
}
