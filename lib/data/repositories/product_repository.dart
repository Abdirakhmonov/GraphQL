import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lesson81_dio/data/models/product.dart';
import 'package:lesson81_dio/data/services/graph_mutation.dart';
import 'package:lesson81_dio/data/services/graph_query.dart';

class ProductRepository {
  final GraphQLClient client;

  ProductRepository(this.client);

  Future<List<Product>> fetchProducts() async {
    final QueryResult result = await client.query(QueryOptions(
      document: gql(fetchProductsQuery),
    ));
    print("Bu natija: $result");

    if (result.hasException) {
      throw result.exception!;
    }

    final List productsJson = result.data?['products'] ?? [];
    return productsJson.map((json) => Product.fromJson(json)).toList();
  }

  Future<Product> addProduct(Product product) async {
    final QueryResult result = await client.mutate(MutationOptions(
      document: gql(addProductMutation),
      variables: product.toJson(),
    ));

    if (result.hasException) {
      throw result.exception!;
    }

    return Product.fromJson(result.data?['addProduct'] ?? {});
  }

  Future<Product> updateProduct(Product product) async {
    final QueryResult result = await client.mutate(
        MutationOptions(document: gql(updateProductMutation), variables: {
      'id': product.id,
      'changes': {
        'title': product.title,
        'price': product.price,
        'description': product.description,
      },
    }));

    if (result.hasException) {
      throw result.exception!;
    }

    return Product.fromJson(result.data?['updateProduct'] ?? {});
  }

  Future<void> deleteProduct(String id) async {
    final QueryResult result = await client.mutate(MutationOptions(
      document: gql(deleteProductMutation),
      variables: {'id': id},
    ));

    if (result.hasException) {
      throw result.exception!;
    }
  }
}
