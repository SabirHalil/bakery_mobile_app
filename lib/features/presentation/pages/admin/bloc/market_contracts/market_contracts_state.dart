part of 'market_contracts_bloc.dart';
@immutable
sealed class MarketContractsState{
  const MarketContractsState();
}

final class MarketContractsLoading extends MarketContractsState {
  const MarketContractsLoading();
}

final class MarketContractsFailure extends MarketContractsState {
  final String? error;
  const MarketContractsFailure({this.error});
}

final class MarketContractsSuccess extends MarketContractsState {
  final List<MarketContractModel>? marketContractsList;

  const MarketContractsSuccess({this.marketContractsList});

}

