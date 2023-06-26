import 'package:flutter/material.dart';
import 'package:graph_ql/chat_gpt/reading_countries/graphql_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Hello world!"),),
      ),
    );
  }
}
