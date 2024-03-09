import 'package:bakery_app/features/domain/usecases/product_counting_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/utils/show_snake_bar.dart';
import '../../../../../data/models/product_counting_added.dart';
import '../../../../../data/models/product_counting_to_add.dart';

part 'product_counting_added_event.dart';
part 'product_counting_added_state.dart';

class ProductCountingAddedBloc
    extends Bloc<ProductCountingAddedEvent, ProductCountingAddedState> {
  final ProductCountingUseCase _productCountingUseCase;
  ProductCountingAddedBloc(this._productCountingUseCase)
      : super(const ProductCountingAddedLoading()) {
    on<GetProductCountingAddedRequested>(onGetProductCountingAdded);
    on<RemoveProductCountingAddedRequested>(onRemoveProductCountingAdded);
    on<UpdateProductCountingAddedRequested>(onUpdateProductCounting);
  }

  void onGetProductCountingAdded(GetProductCountingAddedRequested event,
      Emitter<ProductCountingAddedState> emit) async {
    emit(const ProductCountingAddedLoading());
    final dataState = await _productCountingUseCase
        .getAddedProductsByDateAndCategoryId(event.date, event.categoryId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ProductCountingAddedSuccess(
          productCountingAddedList:
              dataState.data as List<ProductCountingAddedModel>));
    }

    if (dataState is DataFailed) {
      emit(ProductCountingAddedFailure(error: dataState.error!));
    }
  }

  void onRemoveProductCountingAdded(RemoveProductCountingAddedRequested event,
      Emitter<ProductCountingAddedState> emit) async {
    final state = this.state;
    emit(const ProductCountingAddedLoading());

    final dataState = await _productCountingUseCase
        .deleteProductById(event.productCountingAddedModel.id);

    if (dataState is DataSuccess) {
      emit(ProductCountingAddedSuccess(
          productCountingAddedList: [...?state.productCountingAddedList]
            ..remove(event.productCountingAddedModel)));
    }

    if (dataState is DataFailed) {
      emit(ProductCountingAddedFailure(error: dataState.error!));
    }
  }

  void onUpdateProductCounting(UpdateProductCountingAddedRequested event,
      Emitter<ProductCountingAddedState> emit) async {
    final state = this.state;
    if (state is ProductCountingAddedSuccess) {
      emit(const ProductCountingAddedLoading());
      try {
        var staleBreadToAdd = ProductCountingToAddModel(
            id: event.productCountingAddedModel.id,
            quantity: event.productCountingAddedModel.quantity,
            productId: event.productCountingAddedModel.productId,
            date: event.productCountingAddedModel.date);

        final dataState =
            await _productCountingUseCase.updateProduct(staleBreadToAdd);
        if (dataState is DataSuccess) {
          emit(ProductCountingAddedSuccess(productCountingAddedList: [
            ...state.productCountingAddedList!.map((element) =>
                element.id == event.productCountingAddedModel.id
                    ? event.productCountingAddedModel
                    : element)
          ]));
        }

        if (dataState is DataFailed) {
          emit(ProductCountingAddedFailure(error: dataState.error!));
        }
      } catch (e) {
        
      showSnakeBar(e.toString(),null,null);
      rethrow;
      }
    }
  }
}
