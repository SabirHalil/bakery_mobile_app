part of 'product_counting_added_bloc.dart';

sealed class ProductCountingAddedState {
  const ProductCountingAddedState();
  
 get productCountingAddedList => null;
}

final class ProductCountingAddedLoading extends ProductCountingAddedState {
  const ProductCountingAddedLoading();
}

final class ProductCountingAddedFailure extends ProductCountingAddedState {
  final String? error;
  const ProductCountingAddedFailure({this.error});
}

final class ProductCountingAddedSuccess extends ProductCountingAddedState {
  
  @override
  final List<ProductCountingAddedModel>? productCountingAddedList;
  
  const ProductCountingAddedSuccess(
      {this.productCountingAddedList});

}

