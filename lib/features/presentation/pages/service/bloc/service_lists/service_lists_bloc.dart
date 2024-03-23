
import 'package:bakery_app/features/data/models/service_list.dart';
import 'package:bakery_app/features/domain/usecases/service_market_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


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
      emit(ServiceListsFailure(error: dataState.error!.message));
    }
  }
}
