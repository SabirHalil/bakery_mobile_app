

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/models/product.dart';
import 'package:bakery_app/features/domain/usecases/product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
      final ProductUseCase _productUseCase;
  ProductBloc(this._productUseCase) : super(const ProductLoading()) {
    on<GetProductsRequested>(onGetProducts);
    on<AddProductRequested>((onAddProductToList));
    on<RemoveProductRequested>(onRemoveProductFromList);
  }

   void onGetProducts(
   GetProductsRequested event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final dataState = await _productUseCase.getAvailableProductsByCategoryId(event.date,event.categoryId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ProductSuccess(products:dataState.data as List<ProductModel>));
    }

    if (dataState is DataFailed) {
      emit(ProductFailure(error:dataState.error!));
    }
  }

  void onAddProductToList(
      AddProductRequested event, Emitter<ProductState> emit) {
    final state = this.state;
    if (state is ProductSuccess) {
      try {
        emit(ProductSuccess(products: [...?state.products,event.product]));
      } catch (_) {
        emit(ProductFailure(error:DioException.requestCancelled(
            requestOptions: RequestOptions(), reason: "Faild!")));
      }
    }
  }

  void onRemoveProductFromList(
      RemoveProductRequested event, Emitter<ProductState> emit) {
    final state = this.state;
    if (state is ProductSuccess) {
      try {
        
        emit(ProductSuccess(products:
            [...?state.products]..remove(event.product)));
      } catch (_) {
        emit(ProductFailure(error:DioException.requestCancelled(
            requestOptions: RequestOptions(), reason: "Faild!")));
        
      }
    }
  }
  
}
