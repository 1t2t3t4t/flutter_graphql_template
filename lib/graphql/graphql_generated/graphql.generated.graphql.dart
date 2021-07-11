// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:http/http.dart';
import 'package:flutter_graphql_template/graphql/custom_parser.dart';
part 'graphql.generated.graphql.g.dart';

mixin CountryFragmentMixin {
  late String name;
  late List<CountryFragmentMixin$Language> languages;
}

@JsonSerializable(explicitToJson: true)
class Countries$Query$Country extends JsonSerializable
    with EquatableMixin, CountryFragmentMixin {
  Countries$Query$Country();

  factory Countries$Query$Country.fromJson(Map<String, dynamic> json) =>
      _$Countries$Query$CountryFromJson(json);

  @override
  List<Object?> get props => [name, languages];
  @override
  Map<String, dynamic> toJson() => _$Countries$Query$CountryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Countries$Query extends JsonSerializable with EquatableMixin {
  Countries$Query();

  factory Countries$Query.fromJson(Map<String, dynamic> json) =>
      _$Countries$QueryFromJson(json);

  late List<Countries$Query$Country> countries;

  @override
  List<Object?> get props => [countries];
  @override
  Map<String, dynamic> toJson() => _$Countries$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CountryFragmentMixin$Language extends JsonSerializable
    with EquatableMixin {
  CountryFragmentMixin$Language();

  factory CountryFragmentMixin$Language.fromJson(Map<String, dynamic> json) =>
      _$CountryFragmentMixin$LanguageFromJson(json);

  late String code;

  String? name;

  @override
  List<Object?> get props => [code, name];
  @override
  Map<String, dynamic> toJson() => _$CountryFragmentMixin$LanguageToJson(this);
}

final COUNTRIES_QUERY_DOCUMENT = DocumentNode(definitions: [
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

class CountriesQuery extends GraphQLQuery<Countries$Query, JsonSerializable> {
  CountriesQuery();

  @override
  final DocumentNode document = COUNTRIES_QUERY_DOCUMENT;

  @override
  final String operationName = 'Countries';

  @override
  List<Object?> get props => [document, operationName];
  @override
  Countries$Query parse(Map<String, dynamic> json) =>
      Countries$Query.fromJson(json);
}
