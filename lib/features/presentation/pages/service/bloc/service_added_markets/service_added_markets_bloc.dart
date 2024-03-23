import 'package:bakery_app/features/data/models/service_added_market.dart';
import 'package:bakery_app/features/data/models/service_market_to_add.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/error/exceptions.dart';
import '../../../../../../core/resources/data_state.dart';
import '../../../../../domain/entities/service_market_to_add.dart';
import '../../../../../domain/usecases/service_market_usecase.dart';

part 'service_added_markets_event.dart';
part 'service_added_markets_state.dart';

class ServiceAddedMarketsBloc
    extends Bloc<ServiceAddedMarketsEvent, ServiceAddedMarketsState> {
  final ServiceMarketUseCase _serviceMarketssUseCase;
  ServiceAddedMarketsBloc(this._serviceMarketssUseCase)
      : super(const ServiceAddedMarketsLoading()) {
    on<ServiceGetAddedMarketsRequested>(onGetServiceAddedMarkets);
    on<ServiceAddAddedMarketRequested>(onAddMarketToList);
    on<ServiceRemoveAddedMarketRequested>(onRemoveMarketFromList);
    on<ServiceUpdateAddedMarketRequested>(onUpdateMarket);
    on<ServicePostAddedMarketRequested>(onPostMarketsToServer);
  }
  void onGetServiceAddedMarkets(ServiceGetAddedMarketsRequested event,
      Emitter<ServiceAddedMarketsState> emit) async {
    emit(const ServiceAddedMarketsLoading());
    final dataState = await _serviceMarketssUseCase
        .getServiceListMarketsByListId(event.listId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ServiceAddedMarketsSuccess(
          serviceAddedMarkets:
              dataState.data as List<ServiceAddedMarketModel>));
    }

    if (dataState is DataFailed) {
      emit(ServiceAddedMarketsFailure(error: dataState.error!.message));
    }
  }

  void onPostMarketsToServer(ServicePostAddedMarketRequested event,
      Emitter<ServiceAddedMarketsState> emit) async {
    
    
    emit(const ServiceAddedMarketsLoading());
    final dataState = await _serviceMarketssUseCase.addServiceMarkets(
        event.userId, event.markets);
    if (dataState is DataSuccess && dataState.data != null) {
      final updatedDataState = await _serviceMarketssUseCase
          .getServiceListMarketsByListId(dataState.data as int);
      if (updatedDataState is DataSuccess && updatedDataState.data != null) {
        emit(ServiceAddedMarketsSuccess(
            serviceAddedMarkets:
                updatedDataState.data as List<ServiceAddedMarketModel>,
            listId: dataState.data as int));
        event.markets.clear();
      }

      if (updatedDataState is DataFailed) {
        emit(ServiceAddedMarketsFailure(error: updatedDataState.error!.message));
      }
    }

    if (dataState is DataFailed) {
      emit(ServiceAddedMarketsFailure(error: dataState.error!.message));
    }
  }

  void onAddMarketToList(ServiceAddAddedMarketRequested event,
      Emitter<ServiceAddedMarketsState> emit) {
    final state = this.state;
    if (state is ServiceAddedMarketsSuccess) {
      try {
        emit(ServiceAddedMarketsSuccess(serviceAddedMarkets: [
          ...?state.serviceAddedMarkets,
          event.market
        ]));
         } catch (e) {
      throw ServerException(e.toString());
      }
    }
  }

  void onRemoveMarketFromList(ServiceRemoveAddedMarketRequested event,
      Emitter<ServiceAddedMarketsState> emit) async {
    final state = this.state;
    if (state is ServiceAddedMarketsSuccess) {
      try {
        if (event.market.id == 0) {
          emit(ServiceAddedMarketsSuccess(
              serviceAddedMarkets: [...?state.serviceAddedMarkets]
                ..remove(event.market)));
        } else {
          emit(const ServiceAddedMarketsLoading());
          final dataState = await _serviceMarketssUseCase
              .deleteServiceMarketById(event.market.id!);
          if (dataState is DataSuccess) {
            emit(ServiceAddedMarketsSuccess(
                serviceAddedMarkets: [...?state.serviceAddedMarkets]
                  ..remove(event.market)));
          }
          if (dataState is DataFailed) {
            emit(ServiceAddedMarketsFailure(error: dataState.error!.message));
          }
        }
   } catch (e) {
      throw ServerException(e.toString());
      }
    }
  }

  void onUpdateMarket(ServiceUpdateAddedMarketRequested event,
      Emitter<ServiceAddedMarketsState> emit) async {
    final state = this.state;

    if (state is ServiceAddedMarketsSuccess) {
      emit(const ServiceAddedMarketsLoading());
      try {
        if (event.market.id == 0) {
          
          state.serviceAddedMarkets![event.index] = event.market;
          emit(ServiceAddedMarketsSuccess(
              serviceAddedMarkets: state.serviceAddedMarkets!));
        } else {
          final dataState = await _serviceMarketssUseCase.updateServiceMarket(
              ServiceMarketToAddEntity(
                  serviceListId: event.market.serviceListId,
                  marketId: event.market.marketId,
                  quantity: event.market.quantity));

          if (dataState is DataSuccess) {
            emit(ServiceAddedMarketsSuccess(serviceAddedMarkets: [
              ...state.serviceAddedMarkets!.map((element) =>
                  element.marketId == event.market.marketId
                      ? event.market
                      : element)
            ]));
          }
          if (dataState is DataFailed) {
            emit(ServiceAddedMarketsFailure(error: dataState.error!.message));
          }
        }
   } catch (e) {
      throw ServerException(e.toString());
      }
    }
  }
}
