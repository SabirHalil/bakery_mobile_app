import 'package:bakery_app/features/domain/usecases/products_process_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/dough_product_process.dart';

part 'dough_products_process_event.dart';
part 'dough_products_process_state.dart';

class DoughProductsProcessBloc
    extends Bloc<DoughProductsProcessEvent, DoughProductsProcessState> {
  final ProductsProcessUseCase _productsProcessUseCase;
  DoughProductsProcessBloc(this._productsProcessUseCase)
      : super(const DoughProductsProcessLoading()) {
    on<GetDoughProductsRequested>(onGetDoughProductsRequested);
    on<AddDoughProductRequested>(onAddDoughProductRequested);
    on<UpdateDoughProductRequested>(onUpdateDoughProductRequested);
  }
  onGetDoughProductsRequested(GetDoughProductsRequested event,
      Emitter<DoughProductsProcessState> emit) async {
    emit(const DoughProductsProcessLoading());
    final dataState = await _productsProcessUseCase.getAllDoughProducts();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(DoughProductsProcessSuccess(doughProductsProcessList:dataState.data as List<DoughProductProcessModel>));
    }

    if (dataState is DataFailed) {
      emit(DoughProductsProcessFailure(error: dataState.error!));
    }
  }

  onAddDoughProductRequested(AddDoughProductRequested event,Emitter<DoughProductsProcessState> emit) async {
    emit(const DoughProductsProcessLoading());
    final dataState =await _productsProcessUseCase.addDoughProduct(event.product);

    if (dataState is DataSuccess) {
       final dataState = await _productsProcessUseCase.getAllDoughProducts();

       if (dataState is DataSuccess && dataState.data != null) {
        emit(DoughProductsProcessSuccess(
          doughProductsProcessList:
              dataState.data as List<DoughProductProcessModel>));
        }

        if (dataState is DataFailed) {
          emit(DoughProductsProcessFailure(error: dataState.error!));
        }
    }

    if (dataState is DataFailed) {
      emit(DoughProductsProcessFailure(error: dataState.error!));
    }
  }

  onUpdateDoughProductRequested(UpdateDoughProductRequested event,
      Emitter<DoughProductsProcessState> emit) async {
    final state = this.state;
    if (state is DoughProductsProcessSuccess) {
      final dataState =
          await _productsProcessUseCase.updateDoughProduct(event.product);

      if (dataState is DataSuccess) {
        emit(DoughProductsProcessSuccess(doughProductsProcessList: [
          ...state.doughProductsProcessList!.map((element) =>
              element.id == event.product.id ? event.product : element)
        ]));
      }

      if (dataState is DataFailed) {
        emit(DoughProductsProcessFailure(error: dataState.error!));
      }
    }
  }
}
