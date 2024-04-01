part of 'market_hasnot_contract_bloc.dart';

@immutable
sealed class MarketHasnotContractEvent {}

final class GetMarketsNotHaveContractsRequested extends MarketHasnotContractEvent {}