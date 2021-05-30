import 'package:graphql/client.dart';

class GraphQLResult<T> {
  DateTime timestamp;

  /// The source of the result data.
  ///
  /// null when unexecuted.
  /// Will be set when encountering an error during any execution attempt
  QueryResultSource? source;

  /// List<dynamic> or Map<String, dynamic>
  T? data;

  OperationException? exception;

  GraphQLResult.from(QueryResult result, {this.data})
      : exception = result.exception,
        source = result.source,
        timestamp = result.timestamp;

  /// Whether the response includes an exception
  bool get hasException => (exception != null);
}
