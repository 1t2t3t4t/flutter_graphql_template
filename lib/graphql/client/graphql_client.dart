import 'dart:io';

import 'package:artemis/artemis.dart';
import 'package:graphql/client.dart';
import 'package:json_annotation/json_annotation.dart' as JSON;

import 'graphql_result.dart';

abstract class GraphqlLinkProvider {
  Link link({Map<String, String> headers});
}

abstract class GraphqlBearerTokenProvider {
  String? token();
}

abstract class GraphqlClientWrapper {
  Future<GraphQLResult<T>> query<T, U extends JSON.JsonSerializable>(
      GraphQLQuery<T, U> query);

  Future<GraphQLResult<T>> mutate<T, U extends JSON.JsonSerializable>(
      GraphQLQuery<T, U> query);
}

class GraphqlClientWrapperImpl implements GraphqlClientWrapper {
  final GraphqlLinkProvider _linkProvider;
  final GraphqlBearerTokenProvider? tokenProvider;

  GraphqlClientWrapperImpl(this._linkProvider, {this.tokenProvider});

  @override
  Future<GraphQLResult<T>> query<T, U extends JSON.JsonSerializable>(
      GraphQLQuery<T, U> query) async {
    final options = _mapQuery(query);
    final client = await _getClient();
    final result = await client.query(options);
    T? mappedData;
    if (result.data != null) {
      mappedData = query.parse(result.data);
    }
    return GraphQLResult.from(result, data: mappedData);
  }

  @override
  Future<GraphQLResult<T>> mutate<T, U extends JSON.JsonSerializable>(
      GraphQLQuery<T, U> mutation) async {
    final options = _mapMutation(mutation);
    final client = await _getClient();
    final result = await client.mutate(options);
    T? mappedData;
    if (result.data != null) {
      mappedData = mutation.parse(result.data);
    }
    return GraphQLResult.from(result, data: mappedData);
  }

  QueryOptions _mapQuery(GraphQLQuery query) {
    return QueryOptions(
        document: query.document, variables: query.getVariablesMap());
  }

  MutationOptions _mapMutation(GraphQLQuery mutation) {
    return MutationOptions(
        document: mutation.document, variables: mutation.getVariablesMap());
  }

  Future<GraphQLClient> _getClient() async {
    final gqlLink = _linkProvider.link();
    final token = tokenProvider?.token();
    if (token != null) {
      AuthLink authLink = AuthLink(getToken: () => 'Bearer $token');
      Link link = Link.from([authLink, gqlLink]);
      return GraphQLClient(cache: GraphQLCache(), link: link);
    } else {
      return GraphQLClient(cache: GraphQLCache(), link: gqlLink);
    }
  }
}