import 'package:bakery_app/features/domain/usecases/given_product_to_service_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/utils/toast_message.dart';
import '../../../../../data/models/given_product_to_service.dart';

part 'given_product_to_service_event.dart';
part 'given_product_to_service_state.dart';

class GivenProductToServiceBloc
    extends Bloc<GivenProductToServiceEvent, GivenProductToServiceState> {
  final GivenProductToServiceUseCase _givenProductToServiceUseCase;
  GivenProductToServiceBloc(this._givenProductToServiceUseCase)
      : super(const GivenProductToServiceLoading()) {
    on<GivenProductToServiceGetListRequested>(onGetGivenProductToServiceList);
    on<GivenProductToServicePostRequested>(onPostGivenProductToService);
    on<GivenProductToServiceUpdateRequested>(onUpdateGivenProductToService);
    on<GivenProductToServiceDeleteRequested>(onDeleteGivenProductToService);
  }

  void onGetGivenProductToServiceList(
      GivenProductToServiceGetListRequested event,
      Emitter<GivenProductToServiceState> emit) async {
    emit(const GivenProductToServiceLoading());
    
    final dataState = await _givenProductToServiceUseCase
        .getGivenProductToServiceListByDateAndServiceType(
            event.date, event.servisTypeId);
    if (dataState is DataSuccess) {
      emit(GivenProductToServiceSuccess(
          givenProductToServiceList:
              dataState.data as List<GivenProductToServiceModel>));
    }

    if (dataState is DataFailed) {
      emit(GivenProductToServiceFailure(error: dataState.error!));
    }
  }

  void onPostGivenProductToService(GivenProductToServicePostRequested event,
      Emitter<GivenProductToServiceState> emit) async {
    final state = this.state;
    emit(const GivenProductToServiceLoading());

    final dataState = await _givenProductToServiceUseCase.addGivenProductToService(event.givenProductToService);

    if (dataState is DataSuccess) {
      emit(GivenProductToServiceSuccess(givenProductToServiceList: [
        ...?state.givenProductToServiceList,
        event.givenProductToService
      ]));
      showToastMessage('Teslimat başarıyla eklendi');
    }

    if (dataState is DataFailed) {
      emit(GivenProductToServiceFailure(error: dataState.error!));
    }
  }

  void onUpdateGivenProductToService(GivenProductToServiceUpdateRequested event,
      Emitter<GivenProductToServiceState> emit) async {
    final state = this.state;
    emit(const GivenProductToServiceLoading());
    final dataState = await _givenProductToServiceUseCase
        .updateGivenProductToService(event.givenProductToService);

    if (dataState is DataSuccess) {
      emit(GivenProductToServiceSuccess(givenProductToServiceList: [
        ...state.givenProductToServiceList!.map((element) =>
            element.id == event.givenProductToService.id
                ? event.givenProductToService
                : element)
      ]));
      showToastMessage('Teslimat başarıyla güncellendi');
    }

    if (dataState is DataFailed) {
      emit(GivenProductToServiceFailure(error: dataState.error!));
    }
  }

  void onDeleteGivenProductToService(GivenProductToServiceDeleteRequested event,
      Emitter<GivenProductToServiceState> emit) async {
    final state = this.state;
    emit(const GivenProductToServiceLoading());

    final dataState = await _givenProductToServiceUseCase.deleteGivenProductToService(event.givenProductToService.id);

    if (dataState is DataSuccess) {
      emit(GivenProductToServiceSuccess(
          givenProductToServiceList: [...?state.givenProductToServiceList]
            ..remove(event.givenProductToService)));
      showToastMessage('Teslimat başarıyla silindi');
    }

    if (dataState is DataFailed) {
      emit(GivenProductToServiceFailure(error: dataState.error!));
    }
  }
}
