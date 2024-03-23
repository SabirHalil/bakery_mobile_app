part of 'system_time_bloc.dart';
@immutable
sealed class SystemTimeState{
  const SystemTimeState();
}

final class SystemTimeLoading extends SystemTimeState {
  const SystemTimeLoading();
}

final class SystemTimeFailure extends SystemTimeState {
  final String? error;
  const SystemTimeFailure({this.error});
}

final class SystemTimeSuccess extends SystemTimeState {
  final SystemTimeModel? systemTime;

  const SystemTimeSuccess({this.systemTime});
}

