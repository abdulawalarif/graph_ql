import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLQueries {
  static const String countryListQuery = r'''
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


//If you want to search specific regional search just modify the search query like this
//query:
//  query {
//   continent(code:"AS") {
//     code
//     name
//     countries{
//       name
//     }
//   }
// }

// and you will get the output like this

//Output: 
// {
//   "data": {
//     "continent": {
//       "code": "AS",
//       "name": "Asia",
//       "countries": [
//         {
//           "name": "United Arab Emirates"
//         },
//         {
//           "name": "Afghanistan"
//         },
//         {
//           "name": "Armenia"
//         },
//         {
//           "name": "Azerbaijan"
//         },
//         {
//           "name": "Bangladesh"
//         },
//         {
//           "name": "Bahrain"
//         }
//       ]
//     }
//   }
// }