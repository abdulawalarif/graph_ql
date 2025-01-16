import 'package:graph_ql/books_crud/book_model.dart';
import 'package:graph_ql/books_crud/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static GraphQlConfig graphQLConfig = GraphQlConfig();
  GraphQLClient client = graphQLConfig.graphQLToQuery();

  /// fetching books
  Future<List<BookModel>> getBooks({required int limit}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(fetchPolicy: FetchPolicy.noCache, document: gql("""
        query Query(\$limit: Int){
        getBooks(limit: \$limit){
        _id
        author
        title
        year
        }
        }
       """),
        variables: {
          "limit": limit,
        },
        ),
      );

      if(result.hasException){
        throw Exception(result.exception);
      }
      ///print(result.data?['getBooks']);
      List? res = result.data?['getBooks'];

      if( res == null){ ///res!.isEmpty || this is inside of the if condition
        return [];
      }

      List<BookModel> books = res.map((e) => BookModel.fromMap(map: e)).toList();

      return books;
    } catch (error) {
      throw Exception(error);
    }
  }

  /// deleting books
  Future<bool> deleteBook({required String id}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(fetchPolicy: FetchPolicy.noCache, document: gql("""
        mutation Mutation(\$id: ID!){
        deleteBook(ID: \$id)}
       """),
        variables: {
          "id": id,
        },
        ),
      );

      if(result.hasException){
        throw Exception(result.exception);
      }else{
        return true;
      }



    } catch (error) {
      return false;
    }
  }
  /// create book
  Future<bool> createBook({
    required String title,
    required String author,
    required int year,


  }) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
        mutation Mutation(\$bookInput: BookInput!){
        createBook(bookInput: \$bookInput)}
       """),
        variables: {
          "bookInput":{
            "author": author,
            "title": title,
            "year": year,
          }
        },
        ),
      );

      if(result.hasException){
        throw Exception(result.exception);
      }else{
        return true;
      }



    } catch (error) {
      return false;
    }
  }

  /// update book
  Future<bool> updateBook({
    required String id,
    required String title,
    required String author,
    required int year,


  }) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
        mutation Mutation(\$id: ID!, \$bookInput: BookInput!){
        updateBook(ID:\$id, bookInput: \$bookInput)}
       """),
        variables: {
            "id":id,
          "bookInput":{
            "author": author,
            "title": title,
            "year": year,
          }
        },
        ),
      );

      if(result.hasException){
        throw Exception(result.exception);
      }else{
        return true;
      }



    } catch (error) {
      return false;
    }
  }

}
