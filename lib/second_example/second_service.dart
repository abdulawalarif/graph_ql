import 'package:graph_ql/second_example/continet_model.dart';
import 'package:graph_ql/second_example/graphql_second_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLSecondService {
  static GraphQlSecondConfig graphQLConfig = GraphQlSecondConfig();
  GraphQLClient client = graphQLConfig.graphQLToQuery();

  /// fetching books
  Future<List<ContinentModel>> getContinents() async {
    var code = "AF";
    try {
      QueryResult result = await client.query(
        QueryOptions(fetchPolicy: FetchPolicy.noCache, document: gql(

            """
                    query GetContinent($code : String!){
                      continent(code:$code){
                        name
                        countries{
                          name
                        }
                      }
                    }
                  """

        ),

        ),
      );

      if(result.hasException){
        throw Exception(result.exception);
      }
      print(result.data);
      List? res = result.data?['getBooks'];

      if( res == null){ ///res!.isEmpty || this is inside of the if condition
        return [];
      }

      List<ContinentModel> continent = res.map((e) => ContinentModel.fromJson(e)).toList();

      return continent;
    } catch (error) {
      throw Exception(error);
    }
  }

}
