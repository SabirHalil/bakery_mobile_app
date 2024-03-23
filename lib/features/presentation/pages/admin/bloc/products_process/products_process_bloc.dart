import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/product_process.dart';
import '../../../../../domain/usecases/products_process_usecase.dart';

part 'products_process_event.dart';
part 'products_process_state.dart';

class ProductsProcessBloc extends Bloc<ProductsProcessEvent, ProductsProcessState> {
 final ProductsProcessUseCase _productsProcessUseCase;
  ProductsProcessBloc(this._productsProcessUseCase)
      : super(const ProductsProcessLoading()) {
    on<GetProductsRequested>(onGetProductsRequested);
    on<AddProductRequested>(onAddProductRequested);
    on<UpdateProductRequested>(onUpdateProductRequested);
  }
  onGetProductsRequested(GetProductsRequested event,
      Emitter<ProductsProcessState> emit) async {
    emit(const ProductsProcessLoading());
    final dataState = await _productsProcessUseCase.getAllProductsByCategoryId(event.categoryId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ProductsProcessSuccess(
          productsProcessList:
              dataState.data as List<ProductProcessModel>));
    }

    if (dataState is DataFailed) {
      emit(ProductsProcessFailure(error: dataState.error!.message));
    }
  }

  onAddProductRequested(AddProductRequested event,
      Emitter<ProductsProcessState> emit) async {
    emit(const ProductsProcessLoading());

    final dataState =
        await _productsProcessUseCase.addProduct(event.product);

    if (dataState is DataSuccess) {
          final dataState = await _productsProcessUseCase.getAllProductsByCategoryId(event.categoryId);

          if (dataState is DataSuccess && dataState.data != null) {
            emit(ProductsProcessSuccess(
                productsProcessList:
                    dataState.data as List<ProductProcessModel>));
          }

          if (dataState is DataFailed) {
            emit(ProductsProcessFailure(error: dataState.error!.message));
          }
    }

    if (dataState is DataFailed) {
      emit(ProductsProcessFailure(error: dataState.error!.message));
    }
  }

  onUpdateProductRequested(UpdateProductRequested event,
      Emitter<ProductsProcessState> emit) async {
    final state = this.state;
    if (state is ProductsProcessSuccess) {
      final dataState =
          await _productsProcessUseCase.updateProduct(event.product);

      if (dataState is DataSuccess) {
        emit(ProductsProcessSuccess(productsProcessList: [
          ...state.productsProcessList!.map((element) =>
              element.id == event.product.id ? event.product : element)
        ]));
      }

      if (dataState is DataFailed) {
        emit(ProductsProcessFailure(error: dataState.error!.message));
      }
    }
  }
}
