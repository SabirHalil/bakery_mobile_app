part of 'cash_counting_bloc.dart';

sealed class CashCountingEvent {}

final class CashCountingGetListRequested
    extends CashCountingEvent {
  final DateTime date;
  CashCountingGetListRequested({required this.date});
}

final class CashCountingPostRequested
    extends CashCountingEvent {
  final CashCountingModel cashCounting;
  CashCountingPostRequested({required this.cashCounting});
}

final class CashCountingUpdateRequested
    extends CashCountingEvent {
  final CashCountingModel cashCounting;
  CashCountingUpdateRequested({required this.cashCounting});
}

final class CashCountingDeleteRequested
    extends CashCountingEvent {
  final int id;
  CashCountingDeleteRequested({required this.id});
}
