

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/market.dart';
import '../../../../../domain/usecases/market_contract_usecase.dart';

part 'market_hasnot_contract_event.dart';
part 'market_hasnot_contract_state.dart';

class MarketHasnotContractBloc extends Bloc<MarketHasnotContractEvent, MarketHasnotContractState> {
   final MarketContractUseCase _marketContractUseCase;
  MarketHasnotContractBloc(this._marketContractUseCase) : super(const MarketHasnotContractLoading()) {
    on<GetMarketsNotHaveContractsRequested>(onGetMarketsNotHaveContracts);
  }

    onGetMarketsNotHaveContracts(GetMarketsNotHaveContractsRequested event,
      Emitter<MarketHasnotContractState> emit) async {
    emit(const MarketHasnotContractLoading());
    final dataState = await _marketContractUseCase.getMarketsNotHaveContracts();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(MarketHasnotContractSuccess(marketsList: dataState.data as List<MarketModel>));
    }

    if (dataState is DataFailed) {
      emit(MarketHasnotContractFailure(error: dataState.error!.message));
    }
  }

}
