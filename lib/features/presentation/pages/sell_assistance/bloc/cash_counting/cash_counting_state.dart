part of 'cash_counting_bloc.dart';
@immutable
sealed class CashCountingState{
  const CashCountingState();
}

final class CashCountingLoading extends CashCountingState {
  const CashCountingLoading();
}

final class CashCountingFailure extends CashCountingState {
  final String? error;
  const CashCountingFailure({this.error});

}

final class CashCountingSuccess extends CashCountingState {
  
  final CashCountingModel? cashCounting;
  
  const CashCountingSuccess({this.cashCounting});
}

