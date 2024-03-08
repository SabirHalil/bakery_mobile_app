// ignore_for_file: use_build_context_synchronously

import 'package:bakery_app/features/data/models/service_account_left.dart';
import 'package:bakery_app/features/data/models/service_account_to_receive.dart';
import 'package:bakery_app/features/domain/usecases/service_account_usecases.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_account_received/service_account_received_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';

part 'service_account_left_event.dart';
part 'service_account_left_state.dart';

class ServiceAccountLeftBloc
    extends Bloc<ServiceAccountLeftEvent, ServiceAccountLeftState> {
  final ServiceAccountUseCase _serviceAccountUseCase;
  ServiceAccountLeftBloc(this._serviceAccountUseCase)
      : super(const ServiceAccountLeftLoading()) {
    on<ServiceGetAccountLeftRequested>(onGetServiceAccountLeft);
    on<ServicePostAccountLeftRequested>(onPostServiceAccountLeft);
  }
  void onGetServiceAccountLeft(ServiceGetAccountLeftRequested event,
      Emitter<ServiceAccountLeftState> emit) async {
    emit(const ServiceAccountLeftLoading());
    final dataState =
        await _serviceAccountUseCase.getServiceAccountLeftByDate(event.date);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ServiceAccountLeftSuccess(
          serviceAccountLeft: dataState.data as List<ServiceAccountLeftModel>));
    }

    if (dataState is DataFailed) {
      emit(ServiceAccountLeftFailure(error: dataState.error!));
    }
  }

  void onPostServiceAccountLeft(ServicePostAccountLeftRequested event,
      Emitter<ServiceAccountLeftState> emit) async {
    final state = this.state;
    emit(const ServiceAccountLeftLoading());
    final dataState = await _serviceAccountUseCase.addServiceAccountReceived(
        ServiceAccountToReceiveModel(
            id: 0,
            marketId: event.serviceAccountLeftModel.marketId,
            date: DateTime.now(),
            amount: event.paidAmount));

    if (dataState is DataSuccess) {
      emit(ServiceAccountLeftSuccess(
          serviceAccountLeft: [...?state.serviceAccountLeft]
            ..remove(event.serviceAccountLeftModel)));
      event.context
          .read<ServiceAccountReceivedBloc>()
          .add(ServiceGetAccountReceivedRequested(date: DateTime.now()));
    }

    if (dataState is DataFailed) {
      emit(ServiceAccountLeftFailure(error: dataState.error!));
    }
  }

 
}
