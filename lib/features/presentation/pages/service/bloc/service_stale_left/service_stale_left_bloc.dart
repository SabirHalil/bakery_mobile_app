import 'package:bakery_app/features/data/models/service_to_receive_stale.dart';
import 'package:bakery_app/features/domain/usecases/service_stale_usecase.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_stale_received/service_stale_received_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/service_stale.dart';

part 'service_stale_left_event.dart';
part 'service_stale_left_state.dart';

class ServiceStaleLeftBloc
    extends Bloc<ServiceStaleLeftEvent, ServiceStaleLeftState> {
  final ServiceStaleUseCase _serviceStaleUseCase;
  ServiceStaleLeftBloc(this._serviceStaleUseCase)
      : super(const ServiceStaleLeftLoading()) {
    on<ServiceGetStaleLeftRequested>(onGetServiceStale);
    on<ServicePostAccountLeftRequested>(onPostServiceStaleLeft);
  }
  void onGetServiceStale(ServiceGetStaleLeftRequested event,
      Emitter<ServiceStaleLeftState> emit) async {
    emit(const ServiceStaleLeftLoading());
    final dataState =
        await _serviceStaleUseCase.getServiceNotReceivedStaleByDate(event.date);
    
    if (dataState is DataSuccess && dataState.data != null) {
      emit(ServiceStaleLeftSuccess(
          serviceStaleLeft: dataState.data as List<ServiceStaleModel>));
    }

    if (dataState is DataFailed) {
      emit(ServiceStaleLeftFailure(error: dataState.error!));
    }
  }

  void onPostServiceStaleLeft(ServicePostAccountLeftRequested event,
      Emitter<ServiceStaleLeftState> emit) async {
    final state = this.state;
    emit(const ServiceStaleLeftLoading());
    final dataState = await _serviceStaleUseCase.addServiceReceivedStale(
        ServiceToReceiveStaleModel(
            id: 0,
            marketId: event.serviceStaleModel.marketId,
            date: DateTime.now(),
            quantity: event.staleQuantity));

    if (dataState is DataSuccess) {
      emit(ServiceStaleLeftSuccess(
          serviceStaleLeft: [...?state.serviceStaleLeft]
            ..remove(event.serviceStaleModel)));
      event.context
          .read<ServiceStaleReceivedBloc>()
          .add(ServiceGetReceivedStaleRequested(date: DateTime.now()));
    }

    if (dataState is DataFailed) {
      emit(ServiceStaleLeftFailure(error: dataState.error!));
    }
  }
}
