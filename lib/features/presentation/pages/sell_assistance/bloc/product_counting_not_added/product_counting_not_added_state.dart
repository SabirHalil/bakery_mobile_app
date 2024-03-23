part of 'product_counting_not_added_bloc.dart';

sealed class ProductCountingNotAddedState{
  const ProductCountingNotAddedState();
  
get productNotAddedList => null;
}

final class ProductCountingNotAddedLoading extends ProductCountingNotAddedState {
  const ProductCountingNotAddedLoading();
}

final class ProductCountingNotAddedFailure extends ProductCountingNotAddedState {
  final String? error;
  const ProductCountingNotAddedFailure({this.error});
}

final class ProductCountingNotAddedSuccess extends ProductCountingNotAddedState {
  
  @override
  final List<ProductNotAddedModel>? productNotAddedList;
  const ProductCountingNotAddedSuccess({this.productNotAddedList});
}
