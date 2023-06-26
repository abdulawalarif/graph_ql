import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlConfig {
  static HttpLink httpLink = HttpLink(
    "https://books-demo-apollo-server.herokuapp.com/",
  );

  GraphQLClient graphQLToQuery() => GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );
}
