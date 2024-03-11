part of 'bread_price_bloc.dart';

sealed class BreadPriceEvent{}

final class GetBreadPriceRequested extends BreadPriceEvent {}

final class AddBreadPriceRequested extends BreadPriceEvent {
  BreadPriceModel breadPrice;
  AddBreadPriceRequested({required this.breadPrice});
}

final class UpdateBreadPriceRequested extends BreadPriceEvent {
    BreadPriceModel breadPrice;
  UpdateBreadPriceRequested({required this.breadPrice});
}