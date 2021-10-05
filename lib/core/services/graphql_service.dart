import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kyrylo_kaun_test_task/core/constants.dart';

class GraphQLService {
  final GraphQLClient _client = GraphQLClient(
      link: HttpLink(baseApiUrl),
      cache: GraphQLCache(
        store: InMemoryStore(),
      ));

  Future<QueryResult> performQuery(String query, {Map<String, dynamic>? variables}) async {
    QueryOptions options = QueryOptions(document: gql(query), variables: variables ?? {});
    final result = await _client.query(options);
    return result;
  }

  Future<QueryResult> performMutation(String query, {required Map<String, dynamic>? variables}) async {
    MutationOptions options = MutationOptions(document: gql(query), variables: variables ?? {});
    final result = await _client.mutate(options);
    return result;
  }
}
