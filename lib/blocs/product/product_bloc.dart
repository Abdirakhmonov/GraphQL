import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson81_dio/data/models/product.dart';
import 'package:lesson81_dio/data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await repository.fetchProducts();
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });

    on<AddProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        await repository.addProduct(event.product);
        final products = await repository.fetchProducts();
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });

    on<UpdateProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        await repository.updateProduct(event.product);
        final products = await repository.fetchProducts();
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });

    on<DeleteProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        await repository.deleteProduct(event.id);
        final products = await repository.fetchProducts();
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });
  }
}
