import 'package:bakery_app/features/domain/usecases/market_contract_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/market.dart';
import '../../../../../data/models/market_contract.dart';

part 'market_contracts_event.dart';
part 'market_contracts_state.dart';

class MarketContractsBloc
    extends Bloc<MarketContractsEvent, MarketContractsState> {
  final MarketContractUseCase _marketContractUseCase;
  MarketContractsBloc(this._marketContractUseCase)
      : super(const MarketContractsLoading()) {
    on<GetMarketContractsRequested>(onGetMarketContractsRequested);
    on<AddMarketContractRequested>(onAddMarketContractRequested);
    on<UpdateMarketContractRequested>(onUpdateMarketContractRequested);
  }
  onGetMarketContractsRequested(GetMarketContractsRequested event,
      Emitter<MarketContractsState> emit) async {
    emit(const MarketContractsLoading());
    final dataState = await _marketContractUseCase.getAllMarketContracts();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(MarketContractsSuccess(
          marketContractsList: dataState.data as List<MarketContractModel>));
    }

    if (dataState is DataFailed) {
      emit(MarketContractsFailure(error: dataState.error!.message));
    }
  }

  onAddMarketContractRequested(AddMarketContractRequested event,
      Emitter<MarketContractsState> emit) async {
    emit(const MarketContractsLoading());
    final dataState =
        await _marketContractUseCase.addMarketContract(event.marketContract);

    if (dataState is DataSuccess) {
      final dataState = await _marketContractUseCase.getAllMarketContracts();

      if (dataState is DataSuccess && dataState.data != null) {
        emit(MarketContractsSuccess(
            marketContractsList: dataState.data as List<MarketContractModel>));
      }

      if (dataState is DataFailed) {
        emit(MarketContractsFailure(error: dataState.error!.message));
      }
    }

    if (dataState is DataFailed) {
      emit(MarketContractsFailure(error: dataState.error!.message));
    }
  }

  onUpdateMarketContractRequested(UpdateMarketContractRequested event,
      Emitter<MarketContractsState> emit) async {
    final state = this.state;
    if (state is MarketContractsSuccess) {
      final dataState =
          await _marketContractUseCase.updateMarketContract(event.marketContract);

      if (dataState is DataSuccess) {
        emit(MarketContractsSuccess(marketContractsList: [
          ...state.marketContractsList.map((element) =>
              element.id == event.marketContract.id ? event.marketContract : element)
        ]));
      }

      if (dataState is DataFailed) {
        emit(MarketContractsFailure(error: dataState.error!.message));
      }
    }
  }
}
