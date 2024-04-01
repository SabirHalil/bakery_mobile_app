part of 'market_contracts_bloc.dart';

@immutable
sealed class MarketContractsState {
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
  
  final List<MarketContractModel> marketContractsList;

  const MarketContractsSuccess({required this.marketContractsList});
}

final class MarketsLoading extends MarketContractsState {
  const MarketsLoading();
}

final class MarketsFailure extends MarketContractsState {
  final String? error;
  const MarketsFailure({this.error});
}

final class MarketsSuccess extends MarketContractsState {
  final List<MarketModel>? marketsList;

  const MarketsSuccess({this.marketsList});
}
