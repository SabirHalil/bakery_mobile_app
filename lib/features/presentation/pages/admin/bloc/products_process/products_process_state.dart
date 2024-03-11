part of 'products_process_bloc.dart';

@immutable
sealed class ProductsProcessState extends Equatable {
  const ProductsProcessState();
  
get productsProcessList => null;
}

final class ProductsProcessLoading extends ProductsProcessState {
  const ProductsProcessLoading();
  @override
  List<Object?> get props => [];
}

final class ProductsProcessFailure extends ProductsProcessState {
  final DioException? error;
  const ProductsProcessFailure({this.error});

  @override
  List<Object?> get props => [error];
}

final class ProductsProcessSuccess extends ProductsProcessState {
  @override
  final List<ProductProcessModel>? productsProcessList;

   const ProductsProcessSuccess({this.productsProcessList});

  @override
  List<Object?> get props => [productsProcessList];
}

