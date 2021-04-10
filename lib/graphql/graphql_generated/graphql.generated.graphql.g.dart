// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'graphql.generated.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Countries$Query$Country _$Countries$Query$CountryFromJson(
    Map<String, dynamic> json) {
  return Countries$Query$Country()
    ..name = json['name'] as String
    ..languages = (json['languages'] as List<dynamic>)
        .map((e) =>
            CountryFragmentMixin$Language.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$Countries$Query$CountryToJson(
        Countries$Query$Country instance) =>
    <String, dynamic>{
      'name': instance.name,
      'languages': instance.languages.map((e) => e.toJson()).toList(),
    };

Countries$Query _$Countries$QueryFromJson(Map<String, dynamic> json) {
  return Countries$Query()
    ..countries = (json['countries'] as List<dynamic>)
        .map((e) => Countries$Query$Country.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$Countries$QueryToJson(Countries$Query instance) =>
    <String, dynamic>{
      'countries': instance.countries.map((e) => e.toJson()).toList(),
    };

CountryFragmentMixin$Language _$CountryFragmentMixin$LanguageFromJson(
    Map<String, dynamic> json) {
  return CountryFragmentMixin$Language()
    ..code = json['code'] as String
    ..name = json['name'] as String?;
}

Map<String, dynamic> _$CountryFragmentMixin$LanguageToJson(
        CountryFragmentMixin$Language instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
