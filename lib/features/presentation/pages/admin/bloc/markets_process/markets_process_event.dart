part of 'markets_process_bloc.dart';

sealed class MarketsProcessEvent {}

final class GetMarketsProcesssRequested extends MarketsProcessEvent {}

final class AddMarketsProcessRequested extends MarketsProcessEvent {
  MarketModel market;
  AddMarketsProcessRequested({required this.market});
}

final class UpdateMarketsProcessRequested extends MarketsProcessEvent {
    MarketModel market;
  UpdateMarketsProcessRequested({required this.market});
}