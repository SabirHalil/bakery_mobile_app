part of 'stale_product_bloc.dart';

sealed class StaleProductState{
  const StaleProductState();
  
 get staleAddedProductList => null;
}

final class StaleAddedProductLoading extends StaleProductState {
  const StaleAddedProductLoading();

}

final class StaleAddedProductFailure extends StaleProductState {
  final String? error;
  const StaleAddedProductFailure({this.error});
}

final class StaleAddedProductSuccess extends StaleProductState {
  
  @override
  final List<StaleProductAddedModel>? staleAddedProductList;
  
  const StaleAddedProductSuccess(
      {this.staleAddedProductList});
}


