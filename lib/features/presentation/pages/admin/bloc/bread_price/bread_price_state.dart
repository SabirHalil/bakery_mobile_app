part of 'bread_price_bloc.dart';
@immutable
sealed class BreadPriceState {
  const BreadPriceState();
}



final class BreadPriceLoading extends BreadPriceState {
  const BreadPriceLoading();
}

final class BreadPriceFailure extends BreadPriceState {
  final String? error;
  const BreadPriceFailure({this.error});

}

final class BreadPriceSuccess extends BreadPriceState {
  final List<BreadPriceModel>? breadPriceList;

  const BreadPriceSuccess({this.breadPriceList});

}




