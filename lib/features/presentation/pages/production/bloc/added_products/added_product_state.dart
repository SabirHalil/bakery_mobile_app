part of 'added_product_bloc.dart';

@immutable
sealed class AddedProductState extends Equatable {


  const AddedProductState();

 get addedProducts => null;
}

class AddedProductLoading extends AddedProductState {
  const AddedProductLoading();
  
  @override
  List<Object?> get props => [];
}

class AddedProductFailure extends AddedProductState {
    final DioException? error;
  const AddedProductFailure({this.error});
  
  @override
  List<Object?> get props => [error];
}

class AddedProductSuccess extends AddedProductState {
  @override
  final List<AddedProductModel>? addedProducts;
  const AddedProductSuccess({this.addedProducts});
  
  @override
  List<Object?> get props => [addedProducts];
  
}
