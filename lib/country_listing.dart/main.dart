import 'package:flutter/material.dart';
import 'package:graph_ql/country_listing.dart/graphql_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// for listening to changes on data endpoint
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
        home: const CountryListPage(),
      ),
    );
  }
}

class CountryListPage extends StatelessWidget {
  const CountryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country List'),
      ),
      body: Query(
        options: GraphQLQueries.countryListOptions(),
        builder: (
          QueryResult result, {
          Refetch? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.hasException) {
            return const Center(
              child: Text('Error fetching data'),
            );
          }
          if (result.isLoading) {
            return const Center(
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
