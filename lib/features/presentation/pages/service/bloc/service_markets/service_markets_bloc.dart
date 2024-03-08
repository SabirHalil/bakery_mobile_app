

import 'package:bakery_app/features/data/models/service_market.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../domain/usecases/service_market_usecase.dart';

part 'service_markets_event.dart';
part 'service_markets_state.dart';

class ServiceMarketsBloc extends Bloc<ServiceMarketsEvent, ServiceMarketsState> {
   final ServiceMarketUseCase _serviceMarketsUseCase;
  ServiceMarketsBloc(this._serviceMarketsUseCase) : super(const ServiceMarketsLoading()) {
    on<ServiceGetMarketsRequested>(onGetServiceMarkets);
    on<ServiceAddMarketRequested>((onAddMarketToList));
    on<ServiceRemoveMarketRequested>(onRemoveMarketFromList);
  }

 void onGetServiceMarkets(
      ServiceGetMarketsRequested event, Emitter<ServiceMarketsState> emit) async {
    emit(const ServiceMarketsLoading());
    final dataState =
        await _serviceMarketsUseCase.getAvailableServiceMarkets(event.listId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ServiceMarketsSuccess(markets: dataState.data as List<ServiceMarketModel>));
    }

    if (dataState is DataFailed) {
      emit(ServiceMarketsFailure(error:dataState.error));
    }
  }

  void onAddMarketToList(
      ServiceAddMarketRequested event, Emitter<ServiceMarketsState> emit) {
    if (state is ServiceMarketsSuccess) {
      try {
        emit(ServiceMarketsSuccess(markets: [...?state.markets,event.market]));
      } catch (_) {
        emit(ServiceMarketsFailure(error:DioException.requestCancelled(
            requestOptions: RequestOptions(), reason: "Faild!")));
      }
    }
  }

  void onRemoveMarketFromList(ServiceRemoveMarketRequested event, Emitter<ServiceMarketsState> emit) {
    final state = this.state;
    if (state is ServiceMarketsSuccess) {
      try {
        
        emit(ServiceMarketsSuccess(markets:
            [...?state.markets]..remove(event.market)));
      } catch (_) {
        emit(ServiceMarketsFailure(error:DioException.requestCancelled(requestOptions: RequestOptions(), reason: "Faild!")));
        
      }
    }
  }
}
