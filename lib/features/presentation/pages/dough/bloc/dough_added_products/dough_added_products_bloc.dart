import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/models/dough_added_product.dart';
import 'package:bakery_app/features/data/models/dough_product_to_add.dart';
import 'package:bakery_app/features/domain/entities/dough_product_to_add.dart';
import 'package:bakery_app/features/domain/usecases/dough_factory_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'dough_added_products_event.dart';
part 'dough_added_products_state.dart';

class DoughAddedProductsBloc
    extends Bloc<DoughAddedProductsEvent, DoughAddedProductsState> {
  final DoughUseCase _doughUseCase;
  DoughAddedProductsBloc(this._doughUseCase): super(const DoughAddedProductsLoading()) {
    on<DoughGetAddedProductsRequested>(onGetDoughAddedProducts);
    on<DoughAddAddedProductRequested>(onAddProductToList);
    on<DoughRemoveAddedProductRequested>(onRemoveProductFromList);
    on<DoughUpdateAddedProductRequested>(onUpdateProduct);
    on<DoughPostAddedProductRequested>(onPostProductsToServer);
  }

  void onGetDoughAddedProducts(DoughGetAddedProductsRequested event,
      Emitter<DoughAddedProductsState> emit) async {
  
   

    emit(const DoughAddedProductsLoading());
    final dataState =
        await _doughUseCase.getDoughListProductsByListId(event.listId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(DoughAddedProductsSuccess(
          doughAddedProducts: dataState.data as List<DoughAddedProductModel>,
          listId: event.listId));
    }

    if (dataState is DataFailed) {
      emit(DoughAddedProductsFailure(error: dataState.error!));
    }
  }

  void onPostProductsToServer(DoughPostAddedProductRequested event,
      Emitter<DoughAddedProductsState> emit) async {
    emit(const DoughAddedProductsLoading());
    final dataState = await _doughUseCase.addDoughProducts( event.userId, event.products, event.date);
    if (dataState is DataSuccess && dataState.data != null) {
      final updatedDataState = await _doughUseCase.getDoughListProductsByListId(dataState.data as int);
      if (updatedDataState is DataSuccess && updatedDataState.data != null) {
        emit(DoughAddedProductsSuccess(
            doughAddedProducts:updatedDataState.data as List<DoughAddedProductModel>,
            listId: dataState.data as int));
        event.products.clear();
      }

      if (updatedDataState is DataFailed) {
        emit(DoughAddedProductsFailure(error: updatedDataState.error!));
      }
    }

    if (dataState is DataFailed) {
      emit(DoughAddedProductsFailure(error: dataState.error!));
    }
  }

  void onAddProductToList(DoughAddAddedProductRequested event,
      Emitter<DoughAddedProductsState> emit) {
    final state = this.state;
    if (state is DoughAddedProductsSuccess) {
      try {
        emit(DoughAddedProductsSuccess(doughAddedProducts: [...?state.doughAddedProducts, event.product]));
      } catch (_) {
        emit(DoughAddedProductsFailure(
            error: DioException.requestCancelled(
                requestOptions: RequestOptions(), reason: "Faild!")));
      }
    }
  }

  void onRemoveProductFromList(DoughRemoveAddedProductRequested event,
      Emitter<DoughAddedProductsState> emit) async {
    final state = this.state;
    if (state is DoughAddedProductsSuccess) {
      try {
        if (event.product.id == 0) {
          emit(DoughAddedProductsSuccess(
              doughAddedProducts: [...?state.doughAddedProducts]
                ..remove(event.product)));
        } else {
          emit(const DoughAddedProductsLoading());
          final dataState =
              await _doughUseCase.deleteDoughProductById(event.product.id!);
          if (dataState is DataSuccess) {
            emit(DoughAddedProductsSuccess(
                doughAddedProducts: [...?state.doughAddedProducts]
                  ..remove(event.product)));
          }
          if (dataState is DataFailed) {
            emit(DoughAddedProductsFailure(error: dataState.error!));
          }
        }
      } catch (_) {
        emit(DoughAddedProductsFailure(
            error: DioException.requestCancelled(
                requestOptions: RequestOptions(), reason: "Faild!")));
      }
    }
  }

  void onUpdateProduct(DoughUpdateAddedProductRequested event,
      Emitter<DoughAddedProductsState> emit) async {
    final state = this.state;

    if (state is DoughAddedProductsSuccess) {
      emit(const DoughAddedProductsLoading());
      try {
        if (event.product.id == 0) {
          state.doughAddedProducts![event.index] = event.product;
          emit(DoughAddedProductsSuccess(
              doughAddedProducts: state.doughAddedProducts!));
        } else {
          final dataState = await _doughUseCase.updateDoughProduct(
              DoughProductToAddEntity(
                  id: event.product.id,
                  doughFactoryProductId: event.product.doughFactoryProductId,
                  doughFactoryListId: event.product.doughFactoryListId,
                  quantity: event.product.quantity));

          if (dataState is DataSuccess) {
            emit(DoughAddedProductsSuccess(doughAddedProducts: [
              ...state.doughAddedProducts!.map((element) =>
                  element.doughFactoryProductId ==
                          event.product.doughFactoryProductId
                      ? event.product
                      : element)
            ]));
          }
          if (dataState is DataFailed) {
            emit(DoughAddedProductsFailure(error: dataState.error!));
          }
        }
      } catch (_) {
        emit(DoughAddedProductsFailure(
            error: DioException.requestCancelled(
                requestOptions: RequestOptions(), reason: "Faild!")));
      }
    }
  }
}
