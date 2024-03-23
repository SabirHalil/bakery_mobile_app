part of 'products_process_bloc.dart';

@immutable
sealed class ProductsProcessState{
  const ProductsProcessState();

}

final class ProductsProcessLoading extends ProductsProcessState {
  const ProductsProcessLoading();
}

final class ProductsProcessFailure extends ProductsProcessState {
  final String? error;
  const ProductsProcessFailure({this.error});
}

final class ProductsProcessSuccess extends ProductsProcessState {
  final List<ProductProcessModel>? productsProcessList;

   const ProductsProcessSuccess({this.productsProcessList});
}

