part of 'added_product_bloc.dart';

@immutable
sealed class AddedProductState{


  const AddedProductState();
}

class AddedProductLoading extends AddedProductState {
  const AddedProductLoading();
}

class AddedProductFailure extends AddedProductState {
    final String? error;
  const AddedProductFailure({this.error});
}

class AddedProductSuccess extends AddedProductState {
  final List<AddedProductModel>? addedProducts;
  const AddedProductSuccess({this.addedProducts});
 
}
