import 'package:bakery_app/features/presentation/pages/service/bloc/service_debt/service_debt_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/service_debt_detail.dart';
import '../../../../../domain/usecases/service_debt_usecase.dart';

part 'service_debt_detail_event.dart';
part 'service_debt_detail_state.dart';

class ServiceDebtDetailBloc
    extends Bloc<ServiceDebtDetailEvent, ServiceDebtDetailState> {
  final ServiceDebtUseCase _serviceDebtUseCase;
  ServiceDebtDetailBloc(this._serviceDebtUseCase)
      : super(const ServiceDebtDetailLoading()) {
    on<ServiceGetDebtDetailList>(onGetDebtDetailList);
    on<ServiceDeleteDebtPayment>(onDeleteDebtPayment);
    on<ServiceUpdateDebtPayment>(onUpdateDebtPayment);
  }

  void onGetDebtDetailList(ServiceGetDebtDetailList event,
      Emitter<ServiceDebtDetailState> emit) async {
    emit(const ServiceDebtDetailLoading());
    final dataState = await _serviceDebtUseCase
        .getServiceDebtDetailByMarketId(event.marketId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ServiceDebtDetailSuccess(
          serviceDebtDetailList:
              dataState.data as List<ServiceDebtDetailModel>));
    }

    if (dataState is DataFailed) {
      emit(ServiceDebtDetailFailure(error: dataState.error!));
    }
  }

  void onDeleteDebtPayment(ServiceDeleteDebtPayment event,
      Emitter<ServiceDebtDetailState> emit) async {
    final state = this.state;
    emit(const ServiceDebtDetailLoading());
    final dataState = await _serviceDebtUseCase
        .deleteServiceDebtDetail(event.serviceDebtDetail.id);

    if (dataState is DataSuccess) {
      emit(ServiceDebtDetailSuccess(
          serviceDebtDetailList: [...?state.serviceDebtDetailList]
            ..remove(event.serviceDebtDetail)));
            
      event.context.read<ServiceDebtBloc>().add(ServiceGetTotalDebtList());
    }

    if (dataState is DataFailed) {
      emit(ServiceDebtDetailFailure(error: dataState.error!));
    }
  }

  void onUpdateDebtPayment(ServiceUpdateDebtPayment event,
      Emitter<ServiceDebtDetailState> emit) async {
    final state = this.state;
    emit(const ServiceDebtDetailLoading());
    final dataState = await _serviceDebtUseCase
        .updateServiceDebtDetail(event.serviceDebtDetail);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ServiceDebtDetailSuccess(serviceDebtDetailList: [
        ...state.serviceDebtDetailList!.map((element) =>
            element.id == event.serviceDebtDetail.id
                ? event.serviceDebtDetail
                : element)
      ]));
      event.context.read<ServiceDebtBloc>().add(ServiceGetTotalDebtList());
    }

    if (dataState is DataFailed) {
      emit(ServiceDebtDetailFailure(error: dataState.error!));
    }
  }
}
