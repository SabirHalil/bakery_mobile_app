part of 'market_contracts_bloc.dart';

sealed class MarketContractsEvent {}

final class GetMarketContractsRequested extends MarketContractsEvent {}

final class AddMarketContractRequested extends MarketContractsEvent {
  MarketContractModel marketContract;
  AddMarketContractRequested({required this.marketContract});
}

final class UpdateMarketContractRequested extends MarketContractsEvent {
  MarketContractModel marketContract;
  UpdateMarketContractRequested({required this.marketContract});
}
