import 'package:flutter/material.dart';
import 'package:graph_ql/chat_gpt/reading_countries/graphql_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink('https://countries.trevorblades.com/'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'GraphQL Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CountryListPage(),
      ),
    );
  }
}

class CountryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country List'),
      ),
      body: Query(
        options: GraphQLQueries.countryListOptions(),
        builder: (
            QueryResult result, {
              Refetch? refetch,
              FetchMore? fetchMore,
            }) {
          if (result.hasException) {
            return Center(
              child: Text('Error fetching data'),
            );
          }
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final countries = result.data?['countries'];
          return ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final country = countries[index];
              return ListTile(
                title: Text(country['name']),

              );
            },
          );
        },
      ),
    );
  }
}
