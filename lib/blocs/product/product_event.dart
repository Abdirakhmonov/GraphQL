part of "product_bloc.dart";

sealed class ProductEvent {}

class FetchProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final Product product;

  AddProduct({required this.product});
}

class UpdateProduct extends ProductEvent {
  final Product product;

  UpdateProduct({required this.product});
}

class DeleteProduct extends ProductEvent {
  final String id;

  DeleteProduct(this.id);
}
