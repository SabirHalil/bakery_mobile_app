import 'package:bakery_app/features/domain/usecases/received_money_from_service_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/utils/toast_message.dart';
import '../../../../../data/models/received_money_from_service.dart';

part 'received_money_from_service_event.dart';
part 'received_money_from_service_state.dart';

class ReceivedMoneyFromServiceBloc
    extends Bloc<ReceivedMoneyFromServiceEvent, ReceivedMoneyFromServiceState> {
  final ReceivedMoneyFromServiceUseCase _receivedMoneyFromServiceUseCase;

  ReceivedMoneyFromServiceBloc(this._receivedMoneyFromServiceUseCase)
      : super(const ReceivedMoneyFromServiceLoading()) {
    on<ReceivedMoneyFromServiceGetListRequested>(
        onGetReceivedMoneyFromServiceList);
    on<ReceivedMoneyFromServicePostRequested>(onPostReceivedMoneyFromService);
    on<ReceivedMoneyFromServiceUpdateRequested>(
        onUpdateReceivedMoneyFromService);
    on<ReceivedMoneyFromServiceDeleteRequested>(
        onDeleteReceivedMoneyFromService);
  }
  void onGetReceivedMoneyFromServiceList(
      ReceivedMoneyFromServiceGetListRequested event,
      Emitter<ReceivedMoneyFromServiceState> emit) async {
    emit(const ReceivedMoneyFromServiceLoading());
    final dataState = await _receivedMoneyFromServiceUseCase.getReceivedMoneyFromServiceByDateAndServiceType(event.date, event.servisTypeId);
    if (dataState is DataSuccess) {
      
      emit(ReceivedMoneyFromServiceSuccess(receivedMoneyFromService:dataState.data != null?dataState.data as ReceivedMoneyFromServiceModel:null ));
    }

    if (dataState is DataFailed) {
      emit(ReceivedMoneyFromServiceFailure(error: dataState.error!.message));
    }
  }

  void onPostReceivedMoneyFromService(
      ReceivedMoneyFromServicePostRequested event,
      Emitter<ReceivedMoneyFromServiceState> emit) async {

    emit(const ReceivedMoneyFromServiceLoading());

    final dataState = await _receivedMoneyFromServiceUseCase
        .addReceivedMoneyFromService(event.receivedMoneyFromService);

    if (dataState is DataSuccess) {
      emit(ReceivedMoneyFromServiceSuccess(
          receivedMoneyFromService: event.receivedMoneyFromService));
      showToastMessage('Para başarıyla teslim alındı');
    }

    if (dataState is DataFailed) {
      emit(ReceivedMoneyFromServiceFailure(error: dataState.error!.message));
    }
  }

  void onUpdateReceivedMoneyFromService(
      ReceivedMoneyFromServiceUpdateRequested event,
      Emitter<ReceivedMoneyFromServiceState> emit) async {
    emit(const ReceivedMoneyFromServiceLoading());
    final dataState = await _receivedMoneyFromServiceUseCase.updateReceivedMoneyFromService(event.receivedMoneyFromService);

    if (dataState is DataSuccess) {
      emit(ReceivedMoneyFromServiceSuccess(
          receivedMoneyFromService: event.receivedMoneyFromService));
      showToastMessage('Teslimat başarıyla güncellendi');
    }

    if (dataState is DataFailed) {
      emit(ReceivedMoneyFromServiceFailure(error: dataState.error!.message));
    }
  }

  void onDeleteReceivedMoneyFromService(ReceivedMoneyFromServiceDeleteRequested event,
      Emitter<ReceivedMoneyFromServiceState> emit) async {
    emit(const ReceivedMoneyFromServiceLoading());

    final dataState = await _receivedMoneyFromServiceUseCase
        .deleteReceivedMoneyFromServiceById(event.id);

    if (dataState is DataSuccess) {
      emit(const ReceivedMoneyFromServiceSuccess());
      showToastMessage('Teslimat başarıyla silindi');
    }

    if (dataState is DataFailed) {
      emit(ReceivedMoneyFromServiceFailure(error: dataState.error!.message));
    }
  }
}
