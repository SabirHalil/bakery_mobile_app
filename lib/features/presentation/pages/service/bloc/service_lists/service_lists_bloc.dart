// ignore_for_file: depend_on_referenced_packages

import 'package:bakery_app/features/data/models/service_list.dart';
import 'package:bakery_app/features/domain/usecases/service_market_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../../../../../core/resources/data_state.dart';

part 'service_lists_event.dart';
part 'service_lists_state.dart';

class ServiceListsBloc extends Bloc<ServiceListsEvent, ServiceListsState> {
  final ServiceMarketUseCase _serviceListsUseCase;
  ServiceListsBloc(this._serviceListsUseCase) : super(const ServiceListsLoading()) {
    on<ServiceGetListsRequested>(onGetServiceLists);
  }

  void onGetServiceLists(
      ServiceGetListsRequested event, Emitter<ServiceListsState> emit) async {
    emit(const ServiceListsLoading());

    final dataState = await _serviceListsUseCase.getServiceListsByDate(event.dateTime);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(ServiceListsSuccess(
          serviceLists: dataState.data as List<ServiceListModel>));
    }

    if (dataState is DataFailed) {
      emit(ServiceListsFailure(error: dataState.error!));
    }
  }
}
