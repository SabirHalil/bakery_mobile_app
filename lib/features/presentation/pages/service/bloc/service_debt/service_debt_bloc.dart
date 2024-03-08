import 'package:bakery_app/features/data/models/service_debt_detail.dart';
import 'package:bakery_app/features/data/models/service_debt_total.dart';
import 'package:bakery_app/features/domain/usecases/service_debt_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/data_state.dart';

part 'service_debt_event.dart';
part 'service_debt_state.dart';

class ServiceDebtBloc extends Bloc<ServiceDebtEvent, ServiceDebtState> {
  final ServiceDebtUseCase _serviceDebtUseCase;
  ServiceDebtBloc(this._serviceDebtUseCase)
      : super(const ServiceDebtLoading()) {
    on<ServiceGetTotalDebtList>(onGetTotalDebtList);
    on<ServicePostDebtPayment>(onPostDebtPayment);
  }

  void onGetTotalDebtList(
      ServiceGetTotalDebtList event, Emitter<ServiceDebtState> emit) async {
    emit(const ServiceDebtLoading());
    final dataState = await _serviceDebtUseCase.getServiceDebtMarketsList();

    if (dataState is DataSuccess) {
      List<ServiceDebtTotalModel> serviceTotalDebtList =
          dataState.data as List<ServiceDebtTotalModel>;

      serviceTotalDebtList.sort((a, b) => b.amount.compareTo(a.amount));
      emit(ServiceTotalDebtSuccess(serviceTotalDebtList: serviceTotalDebtList));
    }

    if (dataState is DataFailed) {
      emit(ServiceDebtFailure(error: dataState.error!));
    }
  }

  void onPostDebtPayment(
      ServicePostDebtPayment event, Emitter<ServiceDebtState> emit) async {
    emit(const ServiceDebtLoading());
    final dataState =
        await _serviceDebtUseCase.postServicePayDebt(event.serviceDebtDetail);

    if (dataState is DataSuccess) {
      final updatedList = await _serviceDebtUseCase.getServiceDebtMarketsList();
      if (updatedList is DataSuccess && updatedList.data != null) {
        List<ServiceDebtTotalModel> serviceTotalDebtList =
            updatedList.data as List<ServiceDebtTotalModel>;

        serviceTotalDebtList.sort((a, b) => b.amount.compareTo(a.amount));
        emit(ServiceTotalDebtSuccess(
            serviceTotalDebtList: serviceTotalDebtList));
      }

      if (updatedList is DataFailed) {
        emit(ServiceDebtFailure(error: updatedList.error!));
      }
    }

    if (dataState is DataFailed) {
      emit(ServiceDebtFailure(error: dataState.error!));
    }
  }
}
