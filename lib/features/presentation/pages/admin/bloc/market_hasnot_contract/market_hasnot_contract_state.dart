part of 'market_hasnot_contract_bloc.dart';

@immutable
sealed class MarketHasnotContractState {
  const MarketHasnotContractState();
}

final class MarketHasnotContractLoading extends MarketHasnotContractState {
  const MarketHasnotContractLoading();
}

final class MarketHasnotContractFailure extends MarketHasnotContractState {
  final String? error;
  const MarketHasnotContractFailure({this.error});
}

final class MarketHasnotContractSuccess extends MarketHasnotContractState {
  final List<MarketModel>? marketsList;

  const MarketHasnotContractSuccess({this.marketsList});
}
