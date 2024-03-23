part of 'bread_counting_bloc.dart';
@immutable
sealed class BreadCountingState{
  const BreadCountingState();
}

final class BreadCountingLoading extends BreadCountingState {
  const BreadCountingLoading();
}

final class BreadCountingFailure extends BreadCountingState {
  final String? error;
  const BreadCountingFailure({this.error});
}

final class BreadCountingSuccess extends BreadCountingState {

  final BreadCountingModel? breadCounting;
  
  const BreadCountingSuccess({this.breadCounting});
}

