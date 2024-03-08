part of 'cash_counting_bloc.dart';
@immutable
sealed class CashCountingState extends Equatable {
  const CashCountingState();
  
 get cashCounting => [];
}

final class CashCountingLoading extends CashCountingState {
  const CashCountingLoading();
  @override
  List<Object?> get props => [];
}

final class CashCountingFailure extends CashCountingState {
  final DioException? error;
  const CashCountingFailure({this.error});

  @override
  List<Object?> get props => [error];
}

final class CashCountingSuccess extends CashCountingState {
  
  @override
  final CashCountingModel? cashCounting;
  
  const CashCountingSuccess({this.cashCounting});

  @override
  List<Object?> get props => [cashCounting];
}

