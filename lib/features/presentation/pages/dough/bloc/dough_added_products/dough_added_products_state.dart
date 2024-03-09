part of 'dough_added_products_bloc.dart';

@immutable
sealed class DoughAddedProductsState extends Equatable {
  const DoughAddedProductsState();

  get doughAddedProducts => null;
  get listId => null;

}

final class DoughAddedProductsLoading extends DoughAddedProductsState {
  const DoughAddedProductsLoading();
  @override
  List<Object?> get props => [];
}

final class DoughAddedProductsFailure extends DoughAddedProductsState {
  final DioException? error;
  const DoughAddedProductsFailure({this.error});

  @override
  List<Object?> get props => [error];
}

final class DoughAddedProductsSuccess extends DoughAddedProductsState {
  @override
  final List<DoughAddedProductModel>? doughAddedProducts;
  @override
   final int? listId;
   const DoughAddedProductsSuccess({this.doughAddedProducts, this.listId});

  @override
  List<Object?> get props => [doughAddedProducts];
}
