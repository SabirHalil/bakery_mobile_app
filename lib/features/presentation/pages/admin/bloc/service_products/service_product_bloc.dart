import 'package:bakery_app/features/domain/usecases/service_product_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/service_product.dart';

part 'service_product_event.dart';
part 'service_product_state.dart';

class ServiceProductsBloc
    extends Bloc<ServiceProductsEvent, ServiceProductsState> {
  final ServiceProductUseCase _serviceProductUseCase;
  ServiceProductsBloc(this._serviceProductUseCase) : super(const ServiceProductsLoading()) {
    on<GetServiceProductsRequested>(onGetServiceProductsRequested);
    on<AddServiceProductRequested>(onAddServiceProductRequested);
    on<UpdateServiceProductRequested>(onUpdateServiceProductRequested);
  }
  onGetServiceProductsRequested(GetServiceProductsRequested event,
      Emitter<ServiceProductsState> emit) async {
    emit(const ServiceProductsLoading());
    final dataState = await _serviceProductUseCase.getAllServiceProducts();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ServiceProductsSuccess(
          serviceProductsList:
              dataState.data as List<ServiceProductModel>));
    }

    if (dataState is DataFailed) {
      emit(ServiceProductsFailure(error: dataState.error!.message));
    }
  }

  onAddServiceProductRequested(AddServiceProductRequested event,
      Emitter<ServiceProductsState> emit) async {
    emit(const ServiceProductsLoading());
    final dataState =
        await _serviceProductUseCase.addServiceProduct(event.product);

    if (dataState is DataSuccess) {
      final dataState = await _serviceProductUseCase.getAllServiceProducts();

      if (dataState is DataSuccess && dataState.data != null) {
        emit(ServiceProductsSuccess(
            serviceProductsList:
                dataState.data as List<ServiceProductModel>));
      }

      if (dataState is DataFailed) {
        emit(ServiceProductsFailure(error: dataState.error!.message));
      }
    }

    if (dataState is DataFailed) {
      emit(ServiceProductsFailure(error: dataState.error!.message));
    }
  }

  onUpdateServiceProductRequested(UpdateServiceProductRequested event,
      Emitter<ServiceProductsState> emit) async {
    final state = this.state;
    if (state is ServiceProductsSuccess) {
      final dataState =
          await _serviceProductUseCase.updateServiceProduct(event.product);

      if (dataState is DataSuccess) {
        emit(ServiceProductsSuccess(serviceProductsList: [
          ...state.serviceProductsList!.map((element) =>
              element.id == event.product.id ? event.product : element)
        ]));
      }

      if (dataState is DataFailed) {
        emit(ServiceProductsFailure(error: dataState.error!.message));
      }
    }
  }
}
