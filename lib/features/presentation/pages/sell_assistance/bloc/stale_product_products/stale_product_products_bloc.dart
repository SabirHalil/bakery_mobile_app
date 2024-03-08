import 'package:bakery_app/features/domain/usecases/stale_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:equatable/equatable.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/product_not_added.dart';
import '../../../../../data/models/stale_product_to_add.dart';

part 'stale_product_products_event.dart';
part 'stale_product_products_state.dart';

class StaleProductProductsBloc
    extends Bloc<StaleProductProductsEvent, StaleProductProductsState> {
  final StaleProductUseCase _staleProductUseCase;
  StaleProductProductsBloc(this._staleProductUseCase) : super(const StaleProductsLoading()) {
    on<GetStaleProductsRequested>(onGetStaleProduct);
    on<PostStaleProductsRequested>(onPostServiceStaleLeft);
  }

  void onGetStaleProduct(GetStaleProductsRequested event,
      Emitter<StaleProductProductsState> emit) async {
    emit(const StaleProductsLoading());
    final dataState =
        await _staleProductUseCase.getProductListByDate(event.date,event.categoryId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(StaleProductsSuccess(
          staleProductsList: dataState.data as List<ProductNotAddedModel>));
    }

    if (dataState is DataFailed) {
      emit(StaleProductsFailure(error: dataState.error!));
    }
  }

  void onPostServiceStaleLeft(PostStaleProductsRequested event,
      Emitter<StaleProductProductsState> emit) async {
    final state = this.state;
    emit(const StaleProductsLoading());
    final dataState = await _staleProductUseCase.addStaleProduct(
        StaleProductToAddModel(
            id: 0,
            productId: event.staleBreadModel.id!,
            date: DateTime.now(),
            quantity: event.staleQuantity));

    if (dataState is DataSuccess) {
      emit(StaleProductsSuccess(
          staleProductsList: [...?state.staleProductsList]
            ..remove(event.staleBreadModel)));
   
    }

    if (dataState is DataFailed) {
      emit(StaleProductsFailure(error: dataState.error!));
    }
  }
}
