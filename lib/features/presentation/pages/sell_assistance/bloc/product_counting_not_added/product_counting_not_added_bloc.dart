import 'package:bakery_app/features/data/models/product_counting_to_add.dart';
import 'package:bakery_app/features/data/models/product_not_added.dart';
import 'package:bakery_app/features/domain/usecases/product_counting_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/resources/data_state.dart';

part 'product_counting_not_added_event.dart';
part 'product_counting_not_added_state.dart';

class ProductCountingNotAddedBloc
    extends Bloc<ProductCountingNotAddedEvent, ProductCountingNotAddedState> {
  final ProductCountingUseCase _productCountingUseCase;

  ProductCountingNotAddedBloc(this._productCountingUseCase)
      : super(const ProductCountingNotAddedLoading()) {
  on<GetProductCountingNotAddedRequested>(getNotAddedProductsByDateAndCategoryId);
    on<PostProductCountingNotAddedRequested>(onPostServiceStaleLeft);
  }
void getNotAddedProductsByDateAndCategoryId(GetProductCountingNotAddedRequested event,
      Emitter<ProductCountingNotAddedState> emit) async {
    emit(const ProductCountingNotAddedLoading());
    final dataState =
        await _productCountingUseCase.getNotAddedProductsByDateAndCategoryId(event.date,event.categoryId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ProductCountingNotAddedSuccess(
          productNotAddedList: dataState.data as List<ProductNotAddedModel>));
    }

    if (dataState is DataFailed) {
      emit(ProductCountingNotAddedFailure(error: dataState.error!));
    }
  }

  void onPostServiceStaleLeft(PostProductCountingNotAddedRequested event,
      Emitter<ProductCountingNotAddedState> emit) async {
    final state = this.state;
    emit(const ProductCountingNotAddedLoading());
    final dataState = await _productCountingUseCase.addProducts(
        ProductCountingToAddModel(
            id: 0,
            productId: event.productNotAdded.id!,
            date: DateTime.now(),
            quantity: event.productQuantity));

    if (dataState is DataSuccess) {
      emit(ProductCountingNotAddedSuccess(
          productNotAddedList: [...?state.productNotAddedList]
            ..remove(event.productNotAdded)));
   
    }

    if (dataState is DataFailed) {
      emit(ProductCountingNotAddedFailure(error: dataState.error!));
    }
  }
}

