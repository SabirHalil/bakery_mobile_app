
// ignore_for_file: use_build_context_synchronously

import 'package:bakery_app/core/utils/toast_message.dart';
import 'package:bakery_app/features/data/models/service_account_to_receive.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_account_left/service_account_left_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/service_account_received.dart';
import '../../../../../domain/usecases/service_account_usecases.dart';

part 'service_account_received_event.dart';
part 'service_account_received_state.dart';

class ServiceAccountReceivedBloc
    extends Bloc<ServiceAccountReceivedEvent, ServiceAccountReceivedState> {
  final ServiceAccountUseCase _serviceAccountUseCase;
  ServiceAccountReceivedBloc(this._serviceAccountUseCase) : super(const ServiceAccountReceivedLoading()) {
    on<ServiceGetAccountReceivedRequested>(onGetServiceAccountReceived);
    on<ServiceRemoveAccountReceivedRequested>(onRemoveServiceAccountReceived);
    on<ServiceUpdateAccountReceivedRequested>(onUpdateServiceAccountReceived);
  }
  void onGetServiceAccountReceived(ServiceGetAccountReceivedRequested event,
      Emitter<ServiceAccountReceivedState> emit) async {
    emit(const ServiceAccountReceivedLoading());
    final dataState = await _serviceAccountUseCase
        .getServiceAccountReceivedByDate(event.date);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ServiceAccountReceivedSuccess(
          serviceAccountReceived:
              dataState.data as List<ServiceAccountReceivedModel>));
    }

    if (dataState is DataFailed) {
      emit(ServiceAccountReceivedFailure(error: dataState.error!.message));
    }
  }

  void onRemoveServiceAccountReceived(
      ServiceRemoveAccountReceivedRequested event,
      Emitter<ServiceAccountReceivedState> emit) async {
    final state = this.state;
    emit(const ServiceAccountReceivedLoading());

    var serviceReceived = ServiceAccountToReceiveModel(
        id: event.serviceAccountReceivedModel.id,
        amount: event.serviceAccountReceivedModel.amount,
        marketId: event.serviceAccountReceivedModel.marketId,
        date: DateTime.now());

    final dataState = await _serviceAccountUseCase.deleteServiceAccountReceived(serviceReceived);

    if (dataState is DataSuccess) {
      emit(ServiceAccountReceivedSuccess(serviceAccountReceived: [...?state.serviceAccountReceived]..remove(event.serviceAccountReceivedModel)));
      event.context
          .read<ServiceAccountLeftBloc>()
          .add(ServiceGetAccountLeftRequested(date: DateTime.now()));
    }

    if (dataState is DataFailed) {
      emit(ServiceAccountReceivedFailure(error: dataState.error!.message));
    }
  }

  void onUpdateServiceAccountReceived(
      ServiceUpdateAccountReceivedRequested event,
      Emitter<ServiceAccountReceivedState> emit) async {
    final state = this.state;
    if (state is ServiceAccountReceivedSuccess) {
      emit(const ServiceAccountReceivedLoading());
      try {
        var serviceReceived = ServiceAccountToReceiveModel(
            id: event.serviceAccountReceivedModel.id,
            amount: event.serviceAccountReceivedModel.amount,
            marketId: event.serviceAccountReceivedModel.marketId,
            date: DateTime.now());
        final dataState = await _serviceAccountUseCase.updateServiceAccountReceived(serviceReceived);
        if (dataState is DataSuccess) {
          emit(ServiceAccountReceivedSuccess(serviceAccountReceived: [
            ...state.serviceAccountReceived!.map((element) =>
                element.marketId == event.serviceAccountReceivedModel.marketId
                    ? event.serviceAccountReceivedModel
                    : element)
          ]));
        }

        if (dataState is DataFailed) {
          emit(ServiceAccountReceivedFailure(error: dataState.error!.message));
        }
      } catch (e) {
        showToastMessage(e.toString());
      }
    }
  }
}
