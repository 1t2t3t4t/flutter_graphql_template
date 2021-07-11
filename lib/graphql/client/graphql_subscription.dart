part of 'graphql_client.dart';

mixin GraphqlSubscriptionClient implements GraphqlClientWrapper {
  FutureOr<void> initializeClient();

  Future<Stream<GraphQLResult<T>>>
      subscribe<T, U extends JSON.JsonSerializable>(GraphQLQuery<T, U> query);
}

class GraphqlSubscriptionClientImpl extends GraphqlClientWrapperImpl
    with GraphqlSubscriptionClient {
  late GraphQLClient _client;

  GraphqlSubscriptionClientImpl(WebSocketLink webSocketLink,
      {GraphqlBearerTokenProvider? tokenProvider})
      : super(webSocketLink, tokenProvider: tokenProvider);

  @override
  FutureOr<void> initializeClient() async {
    final gqlLink = _link;
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

  @override
  FutureOr<GraphQLClient> _getClient() => _client;
}
