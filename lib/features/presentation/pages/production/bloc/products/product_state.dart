part of 'product_bloc.dart';

@immutable
sealed class ProductState {

  const ProductState();
}

final class ProductLoading extends ProductState {
  const ProductLoading();
  
}

class ProductFailure extends ProductState {
  final String? error;
  const ProductFailure({this.error});
}

class ProductSuccess extends ProductState {
 
  final List<ProductModel>? products;
  const ProductSuccess({this.products});
}
