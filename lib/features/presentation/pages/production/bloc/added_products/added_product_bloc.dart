
import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/models/product_added.dart';

import 'package:bakery_app/features/domain/usecases/product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/product_to_add.dart';
import '../../../../../domain/entities/product_to_add.dart';

part 'added_product_event.dart';
part 'added_product_state.dart';

class AddedProductBloc extends Bloc<AddedProductsEvent, AddedProductState> {
  final ProductUseCase _productUseCase;
  AddedProductBloc(this._productUseCase) : super(const AddedProductLoading()) {
    on<GetAddedProductsRequested>(onGetProducts);
    on<AddAddedProductRequested>(onAddProductToList);
    on<RemoveAddedProductRequested>(onRemoveProductFromList);
    on<UpdateAddedProductRequested>(onUpdateProduct);
    on<PostAddedProductRequested>(onPostProductsToServer);
  }

  void onGetProducts(
      GetAddedProductsRequested event, Emitter<AddedProductState> emit) async {
    emit(const AddedProductLoading());
    
    
    final dataState = await _productUseCase.getAddedProductsByDateAndCategoryId(
        event.date, event.categoryId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(AddedProductSuccess(
          addedProducts: dataState.data as List<AddedProductModel>));
    }

    if (dataState is DataFailed) {
      emit(AddedProductFailure(error: dataState.error!));
    }
  }

  void onPostProductsToServer(
      PostAddedProductRequested event, Emitter<AddedProductState> emit) async {
  
    emit(const AddedProductLoading());
    final dataState = await _productUseCase.addProducts(
        event.userId, event.categoryId, event.products,event.date);
    if (dataState is DataSuccess && dataState.data != null) {
      final updatedDataState =
          await _productUseCase.getAddedProductsByDateAndCategoryId(
              DateTime.now(), event.categoryId);
      if (updatedDataState is DataSuccess && updatedDataState.data != null) {
        emit(AddedProductSuccess(
            addedProducts: updatedDataState.data as List<AddedProductModel>));
        event.products.clear();
      }

      if (updatedDataState is DataFailed) {
        emit(AddedProductFailure(error: updatedDataState.error!));
      }
    }

    if (dataState is DataFailed) {
      emit(AddedProductFailure(error: dataState.error!));
    }
  }

  void onAddProductToList(
      AddAddedProductRequested event, Emitter<AddedProductState> emit) {
    final state = this.state;
    if (state is AddedProductSuccess) {
      try {
        emit(AddedProductSuccess(
            addedProducts: [...?state.addedProducts, event.product]));
      } catch (_) {
        emit(AddedProductFailure(
            error: DioException.requestCancelled(
                requestOptions: RequestOptions(), reason: "Faild!")));
      }
    }
  }

  void onRemoveProductFromList(RemoveAddedProductRequested event,
      Emitter<AddedProductState> emit) async {
    final state = this.state;
    if (state is AddedProductSuccess) {
      try {
        if (event.product.id == 0) {
          emit(AddedProductSuccess(
              addedProducts: [...?state.addedProducts]..remove(event.product)));
        } else {
          emit(const AddedProductLoading());
          final dataState =
              await _productUseCase.deleteProductById(event.product.id!);
          if (dataState is DataSuccess) {
            emit(AddedProductSuccess(
                addedProducts: [...?state.addedProducts]
                  ..remove(event.product)));
          }
          if (dataState is DataFailed) {
            emit(AddedProductFailure(error: dataState.error!));
          }
        }
      } catch (_) {
        emit(AddedProductFailure(
            error: DioException.requestCancelled(
                requestOptions: RequestOptions(), reason: "Faild!")));
      }
    }
  }

  void onUpdateProduct(UpdateAddedProductRequested event,
      Emitter<AddedProductState> emit) async {
    final state = this.state;

    if (state is AddedProductSuccess) {
      emit(const AddedProductLoading());
      try {
        if (event.product.id == 0) {
          state.addedProducts![event.index] = event.product;
          emit(AddedProductSuccess(addedProducts: state.addedProducts!));
        } else {
          final dataState = await _productUseCase.updateProduct(
              ProductToAddEntity(
                  id: event.product.id,
                  productId: event.product.productId,
                  price: 0,
                  productionListId: event.product.productListId,
                  quantity: event.product.quantity));

          if (dataState is DataSuccess) {
            emit(AddedProductSuccess(addedProducts: [
              ...state.addedProducts!.map((element) =>
                  element.productId == event.product.productId
                      ? event.product
                      : element)
            ]));
          }
          if (dataState is DataFailed) {
            emit(AddedProductFailure(error: dataState.error!));
          }
        }
      } catch (_) {
        emit(AddedProductFailure(
            error: DioException.requestCancelled(
                requestOptions: RequestOptions(), reason: "Faild!")));
      }
    }
  }
}
