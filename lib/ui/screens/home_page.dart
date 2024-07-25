import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson81_dio/blocs/product/product_bloc.dart';
import 'package:lesson81_dio/ui/screens/manage_product_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: context.read<ProductBloc>()..add(FetchProducts()),
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ListTile(
                    title: Text(product.title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => ManageProductScreen(
                                isEdit: true,
                                product: product,
                              ),
                            ));
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context
                                .read<ProductBloc>()
                                .add(DeleteProduct(product.id as String));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No products available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => const ManageProductScreen(isEdit: false),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
