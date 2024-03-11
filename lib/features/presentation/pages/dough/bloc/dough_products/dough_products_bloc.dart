

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/models/product_not_added.dart';
import 'package:bakery_app/features/domain/usecases/dough_factory_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'dough_products_event.dart';
part 'dough_products_state.dart';

class DoughProductsBloc extends Bloc<DoughProductsEvent, DoughProductsState> {
  final DoughUseCase _doughUseCase;
  DoughProductsBloc(this._doughUseCase) : super(const DoughProductsLoading()) {
    on<DoughGetProductsRequested>(onGetDoughProducts);
    on<DoughAddProductRequested>((onAddProductToList));
    on<DoughRemoveProductRequested>(onRemoveProductFromList);
  }

  void onGetDoughProducts(
      DoughGetProductsRequested event, Emitter<DoughProductsState> emit) async {
    emit(const DoughProductsLoading());
    final dataState = await _doughUseCase.getAvailableDoughProducts(event.listId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(DoughProductsSuccess(
          doughProducts: dataState.data as List<ProductNotAddedModel>));
    }

    if (dataState is DataFailed) {
      emit(DoughProductsFailure(error: dataState.error));
    }
  }

  void onAddProductToList(
      DoughAddProductRequested event, Emitter<DoughProductsState> emit) {
    final state = this.state;
    if (state is DoughProductsSuccess) {
      try {
        emit(DoughProductsSuccess(doughProducts: [...?state.doughProducts, event.product]));
      } catch (_) {
        emit(DoughProductsFailure(
            error: DioException.requestCancelled(
                requestOptions: RequestOptions(), reason: "Faild!")));
      }
    }
  }

  void onRemoveProductFromList(
      DoughRemoveProductRequested event, Emitter<DoughProductsState> emit) {
    final state = this.state;
    if (state is DoughProductsSuccess) {
      try {
        
        emit(DoughProductsSuccess(
            doughProducts: [...?state.doughProducts]..remove(event.product)));
      } catch (_) {
        emit(DoughProductsFailure(
            error: DioException.requestCancelled(
                requestOptions: RequestOptions(), reason: "Faild!")));
        
      }
    }
  }
}
