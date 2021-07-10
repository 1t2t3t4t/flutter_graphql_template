import 'package:artemis/schema/graphql_query.dart';
import 'package:graphql/client.dart';
import 'package:json_annotation/json_annotation.dart' as JSON;

import 'graphql_client.dart';
import 'graphql_result.dart';

mixin GraphqlSubscriptionClient {
  Future<void> initializeClient();

  Future<GraphQLResult<T>> query<T, U extends JSON.JsonSerializable>(
      GraphQLQuery<T, U> query);
  Future<GraphQLResult<T>> mutate<T, U extends JSON.JsonSerializable>(
      GraphQLQuery<T, U> query);

  Future<Stream<GraphQLResult<T>>>
      subscribe<T, U extends JSON.JsonSerializable>(GraphQLQuery<T, U> query);
}

class GraphqlSubscriptionClientImpl with GraphqlSubscriptionClient {
  WebSocketLink _webSocketLink;
  final GraphqlBearerTokenProvider? tokenProvider;

  late GraphQLClient _client;

  GraphqlSubscriptionClientImpl(this._webSocketLink, {this.tokenProvider});

  Future<void> initializeClient() async {
    final gqlLink = _webSocketLink;
    final token = await tokenProvider?.token();
    if (token != null) {
      AuthLink authLink = AuthLink(getToken: () => 'Bearer $token');
      Link link = Link.from([authLink, gqlLink]);
      _client = GraphQLClient(cache: GraphQLCache(), link: link);
    } else {
      _client =
          GraphQLClient(cache: GraphQLCache(), link: Link.from([gqlLink]));
    }
  }

  @override
  Future<GraphQLResult<T>> query<T, U extends JSON.JsonSerializable>(
      GraphQLQuery<T, U> query) async {
    final options = _mapQuery(query);
    final result = await _client.query(options);
    T? mappedData;
    final data = result.data;
    if (data != null) {
      mappedData = query.parse(data);
    }
    return GraphQLResult.from(result, data: mappedData);
  }

  @override
  Future<GraphQLResult<T>> mutate<T, U extends JSON.JsonSerializable>(
      GraphQLQuery<T, U> mutation) async {
    final options = _mapMutation(mutation);
    final result = await _client.mutate(options);
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

  @override
  Future<Stream<GraphQLResult<T>>>
      subscribe<T, U extends JSON.JsonSerializable>(
          GraphQLQuery<T, U> subscription) async {
    final options = _mapSubscription(subscription);
    return _client.subscribe(options).map((event) {
      T? mappedData;
      final data = event.data;
      if (data != null) {
        mappedData = subscription.parse(data);
      }
      return GraphQLResult.from(event, data: mappedData);
    });
  }

  SubscriptionOptions _mapSubscription(GraphQLQuery subscription) {
    return SubscriptionOptions(
        document: subscription.document,
        variables: subscription.getVariablesMap());
  }
}
