part of 'market_contracts_bloc.dart';

sealed class MarketContractsEvent{}

final class GetMarketContractsRequested extends MarketContractsEvent {}

final class AddMarketContractRequested extends MarketContractsEvent {
  MarketContractModel product;
  AddMarketContractRequested({required this.product});
}

final class UpdateMarketContractRequested extends MarketContractsEvent {
    MarketContractModel product;
  UpdateMarketContractRequested({required this.product});
}