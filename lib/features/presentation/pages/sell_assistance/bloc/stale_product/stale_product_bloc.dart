import 'package:bakery_app/features/data/models/stale_product_added.dart';
import 'package:bakery_app/features/data/models/stale_product_to_add.dart';
import 'package:bakery_app/features/domain/usecases/stale_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/utils/toast_message.dart';

part 'stale_product_event.dart';
part 'stale_product_state.dart';

class StaleProductBloc extends Bloc<StaleProductEvent, StaleProductState> {
  final StaleProductUseCase _staleProductUseCase;
  StaleProductBloc(this._staleProductUseCase) : super(const StaleAddedProductLoading()) {
    on<GetStaleAddedProductRequested>(onGetStaleAddedProduct);
    on<RemoveStaleAddedProductRequested>(onRemoveStaleAddedProduct);
    on<UpdateStaleAddedProductRequested>(onUpdateStaleProduct);
  }

  void onGetStaleAddedProduct(GetStaleAddedProductRequested event,
      Emitter<StaleProductState> emit) async {
    emit(const StaleAddedProductLoading());
    final dataState =
        await _staleProductUseCase.getAddedStaleProductListByDate(event.date,event.categoryId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(StaleAddedProductSuccess(
          staleAddedProductList: dataState.data as List<StaleProductAddedModel>));
    }

    if (dataState is DataFailed) {
      emit(StaleAddedProductFailure(error: dataState.error!));
    }
  }

   void onRemoveStaleAddedProduct(RemoveStaleAddedProductRequested event,
      Emitter<StaleProductState> emit) async {
    final state = this.state;
    emit(const StaleAddedProductLoading());

    final dataState = await _staleProductUseCase
        .deleteStaleProduct(event.staleProductAddedModel.id);

    if (dataState is DataSuccess) {
 
      emit(StaleAddedProductSuccess(
          staleAddedProductList: [...?state.staleAddedProductList]
            ..remove(event.staleProductAddedModel)));
    }

    if (dataState is DataFailed) {
      emit(StaleAddedProductFailure(error: dataState.error!));
    }
  }

   void onUpdateStaleProduct(UpdateStaleAddedProductRequested event,Emitter<StaleProductState> emit) async {
    final state = this.state;
    if (state is StaleAddedProductSuccess) {
      emit(const StaleAddedProductLoading());
      try {
        var staleBreadToAdd = StaleProductToAddModel(
            id: event.staleProductAddedModel.id,
            quantity: event.staleProductAddedModel.quantity,
            productId: event.staleProductAddedModel.productId,
            date: DateTime.now());
       
        final dataState = await _staleProductUseCase
            .updateStaleProduct(staleBreadToAdd);
        if (dataState is DataSuccess) {
          emit(StaleAddedProductSuccess(staleAddedProductList: [
            ...state.staleAddedProductList!.map((element) =>
                element.id == event.staleProductAddedModel.id
                    ? event.staleProductAddedModel
                    : element)
          ]));
        }

        if (dataState is DataFailed) {
          emit(StaleAddedProductFailure(error: dataState.error!));
        }
      } catch (e) {
        
        showToastMessage(e.toString());
      }
    }
  }

}
