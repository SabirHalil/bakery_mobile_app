part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {

  const ProductState();

  get products => [];
}

final class ProductLoading extends ProductState {
  const ProductLoading();
  
  @override
  List<Object?> get props => [];
}

class ProductFailure extends ProductState {
  final DioException? error;
  const ProductFailure({this.error});
  
  @override
  List<Object?> get props => [error];
}

class ProductSuccess extends ProductState {
  @override
  final List<ProductModel>? products;
  const ProductSuccess({this.products});
  
  @override
  List<Object?> get props => [products];
}
