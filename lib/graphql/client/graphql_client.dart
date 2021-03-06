import 'dart:async';

import 'package:artemis/artemis.dart';
import 'package:graphql/client.dart';
import 'package:json_annotation/json_annotation.dart' as json;

part 'graphql_subscription.dart';
part 'graphql_result.dart';

mixin GraphqlBearerTokenProvider {
  FutureOr<String?> token();
}

abstract class GraphqlClientWrapper {
  Future<GraphQLResult<T>> query<T, U extends json.JsonSerializable>(
      GraphQLQuery<T, U> query);
  Future<GraphQLResult<T>> mutate<T, U extends json.JsonSerializable>(
      GraphQLQuery<T, U> query);
}

class GraphqlClientWrapperImpl implements GraphqlClientWrapper {
  final Link _link;
  final GraphqlBearerTokenProvider? tokenProvider;

  GraphqlClientWrapperImpl(this._link, {this.tokenProvider});

  @override
  Future<GraphQLResult<T>> query<T, U extends json.JsonSerializable>(
      GraphQLQuery<T, U> query) async {
    final options = _mapQuery(query);
    final client = await _getClient();
    final result = await client.query(options);
    T? mappedData;
    final data = result.data;
    if (data != null) {
      mappedData = query.parse(data);
    }
    return GraphQLResult.from(result, data: mappedData);
  }

  @override
  Future<GraphQLResult<T>> mutate<T, U extends json.JsonSerializable>(
      GraphQLQuery<T, U> mutation) async {
    final options = _mapMutation(mutation);
    final client = await _getClient();
    final result = await client.mutate(options);
    T? mappedData;
    final data = result.data;
    if (data != null) {
      mappedData = mutation.parse(data);
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

  FutureOr<GraphQLClient> _getClient() async {
    final gqlLink = _link;
    final token = await tokenProvider?.token();
    if (token != null) {
      final AuthLink authLink = AuthLink(getToken: () => 'Bearer $token');
      final Link link = Link.from([authLink, gqlLink]);
      return GraphQLClient(cache: GraphQLCache(), link: link);
    } else {
      return GraphQLClient(cache: GraphQLCache(), link: gqlLink);
    }
  }
}
