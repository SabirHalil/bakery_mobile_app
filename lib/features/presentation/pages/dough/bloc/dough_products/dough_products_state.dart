part of 'dough_products_bloc.dart';

@immutable
sealed class DoughProductsState{
  const DoughProductsState();

}

final class DoughProductsLoading extends DoughProductsState {
  const DoughProductsLoading();
}

final class DoughProductsFailure extends DoughProductsState {
  final String? error;
  const DoughProductsFailure({this.error});
}

final class DoughProductsSuccess extends DoughProductsState {
  final List<ProductNotAddedModel>? doughProducts;
  const DoughProductsSuccess({this.doughProducts});
}
