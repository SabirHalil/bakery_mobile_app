part of 'stale_product_products_bloc.dart';

sealed class StaleProductProductsState{
  const StaleProductProductsState();
  
 get staleProductsList => null;
}

final class StaleProductsLoading extends StaleProductProductsState {
  const StaleProductsLoading();
}

final class StaleProductsFailure extends StaleProductProductsState {
  final String? error;
  const StaleProductsFailure({this.error});
}

final class StaleProductsSuccess extends StaleProductProductsState {
  
  @override
  final List<ProductNotAddedModel>? staleProductsList;
  const StaleProductsSuccess({this.staleProductsList});
}
