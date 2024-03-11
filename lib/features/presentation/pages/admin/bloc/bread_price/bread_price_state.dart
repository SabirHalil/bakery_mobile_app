part of 'bread_price_bloc.dart';
@immutable
sealed class BreadPriceState extends Equatable {
  const BreadPriceState();
  
   get breadPriceList => null;
}

final class BreadPriceLoading extends BreadPriceState {
  const BreadPriceLoading();
  @override
  List<Object?> get props => [];
}

final class BreadPriceFailure extends BreadPriceState {
  final DioException? error;
  const BreadPriceFailure({this.error});

  @override
  List<Object?> get props => [error];
}

final class BreadPriceSuccess extends BreadPriceState {
  @override
  final List<BreadPriceModel>? breadPriceList;

  const BreadPriceSuccess({this.breadPriceList});

  @override
  List<Object?> get props => [breadPriceList];
}




