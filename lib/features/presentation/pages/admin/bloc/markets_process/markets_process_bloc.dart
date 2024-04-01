import 'package:bakery_app/features/domain/usecases/market_usecase.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/market.dart';

part 'markets_process_event.dart';
part 'markets_process_state.dart';

class MarketsProcessBloc
    extends Bloc<MarketsProcessEvent, MarketsProcessState> {
  final MarketUseCase _marketUseCase;
  MarketsProcessBloc(this._marketUseCase)
      : super(const MarketsProcessLoading()) {
    on<GetMarketsProcesssRequested>(onGetMarketsProcesssRequested);
    on<AddMarketsProcessRequested>(onAddMarketsProcessRequested);
    on<UpdateMarketsProcessRequested>(onUpdateMarketsProcessRequested);
    on<FilterMarketsProcessRequested>(onFilterMarketsProcessRequested);
  }
  onGetMarketsProcesssRequested(GetMarketsProcesssRequested event,
      Emitter<MarketsProcessState> emit) async {
    print('get markets');
    print('get it ');
    emit(const MarketsProcessLoading());
    final dataState = await _marketUseCase.getAllMarkets();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(MarketsProcessSuccess(
          marketsProcessList: dataState.data as List<MarketModel>));
    }

    if (dataState is DataFailed) {
      emit(MarketsProcessFailure(error: dataState.error!.message));
    }
  }

  onAddMarketsProcessRequested(AddMarketsProcessRequested event,
      Emitter<MarketsProcessState> emit) async {
    emit(const MarketsProcessLoading());
    final dataState = await _marketUseCase.addMarket(event.market);

    if (dataState is DataSuccess) {
      final dataState = await _marketUseCase.getAllMarkets();

      if (dataState is DataSuccess && dataState.data != null) {
        emit(MarketsProcessSuccess(
            marketsProcessList: dataState.data as List<MarketModel>));
      }

      if (dataState is DataFailed) {
        emit(MarketsProcessFailure(error: dataState.error!.message));
      }
    }

    if (dataState is DataFailed) {
      emit(MarketsProcessFailure(error: dataState.error!.message));
    }
  }

  onUpdateMarketsProcessRequested(UpdateMarketsProcessRequested event,
      Emitter<MarketsProcessState> emit) async {
    final state = this.state;
    if (state is MarketsProcessSuccess) {
      final dataState = await _marketUseCase.updateMarket(event.market);

      if (dataState is DataSuccess) {
        emit(MarketsProcessSuccess(marketsProcessList: [
          ...state.marketsProcessList!.map((element) =>
              element.id == event.market.id ? event.market : element)
        ]));
      }

      if (dataState is DataFailed) {
        emit(MarketsProcessFailure(error: dataState.error!.message));
      }
    }
  }

  onFilterMarketsProcessRequested(FilterMarketsProcessRequested event,
      Emitter<MarketsProcessState> emit) async {
    
    if (state is MarketsProcessSuccess) {

     
        emit(MarketsProcessSuccess(
            marketsProcessList: event.marketList));
   
    }
  }
}
