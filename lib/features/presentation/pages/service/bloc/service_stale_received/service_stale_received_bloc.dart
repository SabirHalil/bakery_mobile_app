import 'package:bakery_app/features/data/models/service_received_stale.dart';
import 'package:bakery_app/features/data/models/service_to_receive_stale.dart';
import 'package:bakery_app/features/domain/usecases/service_stale_usecase.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_stale_left/service_stale_left_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/utils/toast_message.dart';

part 'service_stale_received_event.dart';
part 'service_stale_received_state.dart';

class ServiceStaleReceivedBloc
    extends Bloc<ServiceStaleReceivedEvent, ServiceStaleReceivedState> {
  final ServiceStaleUseCase _serviceStaleUseCase;
  ServiceStaleReceivedBloc(this._serviceStaleUseCase)
      : super(const ServiceStaleReceivedLoading()) {
    on<ServiceGetReceivedStaleRequested>(onGetServiceStaleReceived);
    on<ServiceRemoveReceivedStaleRequested>(onRemoveServiceStaleReceived);
    on<ServiceUpdateReceivedStaleRequested>(onUpdateServiceStaleReceived);
  }

  void onGetServiceStaleReceived(ServiceGetReceivedStaleRequested event,
      Emitter<ServiceStaleReceivedState> emit) async {
    emit(const ServiceStaleReceivedLoading());
    final dataState =
        await _serviceStaleUseCase.getServiceReceivedStaleByDate(event.date);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ServiceStaleReceivedSuccess(
          serviceReceivedStale:
              dataState.data as List<ServiceReceivedStaleModel>));
    }

    if (dataState is DataFailed) {
      emit(ServiceStaleReceivedFailure(error: dataState.error!));
    }
  }

  void onRemoveServiceStaleReceived(ServiceRemoveReceivedStaleRequested event,
      Emitter<ServiceStaleReceivedState> emit) async {
    final state = this.state;
    emit(const ServiceStaleReceivedLoading());

    final dataState = await _serviceStaleUseCase
        .deleteServiceReceivedStale(event.serviceReceivedStaleModel.id);

    if (dataState is DataSuccess) {
      
      
      emit(ServiceStaleReceivedSuccess(
          serviceReceivedStale: [...?state.serviceReceivedStale]
            ..remove(event.serviceReceivedStaleModel)));
      event.context
          .read<ServiceStaleLeftBloc>()
          .add(ServiceGetStaleLeftRequested(date: DateTime.now()));
    }

    if (dataState is DataFailed) {
      emit(ServiceStaleReceivedFailure(error: dataState.error!));
    }
  }

  void onUpdateServiceStaleReceived(ServiceUpdateReceivedStaleRequested event,
      Emitter<ServiceStaleReceivedState> emit) async {
    final state = this.state;
    if (state is ServiceStaleReceivedSuccess) {
      emit(const ServiceStaleReceivedLoading());
      try {
        var serviceStaleReceived = ServiceToReceiveStaleModel(
            id: event.serviceReceivedStaleModel.id,
            quantity: event.serviceReceivedStaleModel.quantity,
            marketId: event.serviceReceivedStaleModel.marketId,
            date: DateTime.now());
        
        final dataState = await _serviceStaleUseCase
            .updateServiceReceivedStale(serviceStaleReceived);
        if (dataState is DataSuccess) {
          emit(ServiceStaleReceivedSuccess(serviceReceivedStale: [
            ...state.serviceReceivedStale!.map((element) =>
                element.marketId == event.serviceReceivedStaleModel.marketId
                    ? event.serviceReceivedStaleModel
                    : element)
          ]));
        }

        if (dataState is DataFailed) {
          emit(ServiceStaleReceivedFailure(error: dataState.error!));
        }
      } catch (e) {
        
      showToastMessage(e.toString(),duration: 1);
      rethrow;
      }
    }
  }
}
