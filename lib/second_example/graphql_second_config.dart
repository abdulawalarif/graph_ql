import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlSecondConfig {
  static HttpLink httpLink = HttpLink("https://countries.trevorblades.com/");

  GraphQLClient graphQLToQuery() => GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );
}
