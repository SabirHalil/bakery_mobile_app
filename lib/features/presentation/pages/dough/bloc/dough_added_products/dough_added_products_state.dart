part of 'dough_added_products_bloc.dart';

@immutable
sealed class DoughAddedProductsState {
  const DoughAddedProductsState();
}

final class DoughAddedProductsLoading extends DoughAddedProductsState {
  const DoughAddedProductsLoading();
}

final class DoughAddedProductsFailure extends DoughAddedProductsState {
  final String? error;
  const DoughAddedProductsFailure({this.error});
}

final class DoughAddedProductsSuccess extends DoughAddedProductsState {
  
  final List<DoughAddedProductModel>? doughAddedProducts;

   final int? listId;
   const DoughAddedProductsSuccess({this.doughAddedProducts, this.listId});

}
