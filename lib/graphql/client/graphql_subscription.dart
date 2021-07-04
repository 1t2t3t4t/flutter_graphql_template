import 'package:artemis/schema/graphql_query.dart';
import 'package:graphql/client.dart';
import 'package:json_annotation/json_annotation.dart' as JSON;

import 'graphql_client.dart';
import 'graphql_result.dart';

mixin GraphqlSubscriptionClient {
  Future<Stream<GraphQLResult<T>>>
      subscribe<T, U extends JSON.JsonSerializable>(GraphQLQuery<T, U> query);
}

class GraphqlSubscriptionClientImpl with GraphqlSubscriptionClient {
  WebSocketLink _webSocketLink;
  final GraphqlBearerTokenProvider? tokenProvider;

  GraphqlSubscriptionClientImpl(this._webSocketLink, {this.tokenProvider});

  @override
  Future<Stream<GraphQLResult<T>>>
      subscribe<T, U extends JSON.JsonSerializable>(
          GraphQLQuery<T, U> subscription) async {
    final options = _mapSubscription(subscription);
    final client = await _getClient();
    return client.subscribe(options).map((event) {
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

  Future<GraphQLClient> _getClient() async {
    final gqlLink = _webSocketLink;
    final token = await tokenProvider?.token();
    if (token != null) {
      AuthLink authLink = AuthLink(getToken: () => 'Bearer $token');
      Link link = Link.from([authLink, gqlLink]);
      return GraphQLClient(cache: GraphQLCache(), link: link);
    } else {
      return GraphQLClient(cache: GraphQLCache(), link: Link.from([gqlLink]));
    }
  }
}
