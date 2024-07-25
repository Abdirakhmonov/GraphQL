import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lesson81_dio/blocs/product/product_bloc.dart';
import 'package:lesson81_dio/core/app.dart';
import 'package:lesson81_dio/data/repositories/product_repository.dart';

void main() {
  final HttpLink httpLink =
      HttpLink('https://api.escuelajs.co/graphql/products');
  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final GraphQLClient client;

  const MyApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => ProductRepository(client),
        child: BlocProvider(
          create: (context) => ProductBloc(context.read<ProductRepository>()),
          child: MainApp(),
        ),
      ),
    );
  }
}
