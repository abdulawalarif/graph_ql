import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLQueries {
  static final String countryListQuery = r'''
    query {
      countries {
        name
        code
      }
    }
  ''';

  static QueryOptions countryListOptions() {
    return QueryOptions(
      document: gql(countryListQuery),
    );
  }
}
