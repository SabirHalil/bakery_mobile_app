part of 'products_process_bloc.dart';

sealed class ProductsProcessEvent {}

final class GetProductsRequested extends ProductsProcessEvent {
  final int categoryId;
  GetProductsRequested(this.categoryId);
}

final class AddProductRequested extends ProductsProcessEvent {
  final int categoryId;
  final ProductProcessModel product;
  AddProductRequested({required this.product, required this.categoryId});
}

final class UpdateProductRequested extends ProductsProcessEvent {
  final ProductProcessModel product;
  UpdateProductRequested({required this.product});
}
