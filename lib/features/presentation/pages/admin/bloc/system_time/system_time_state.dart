part of 'system_time_bloc.dart';
@immutable
sealed class SystemTimeState extends Equatable {
  const SystemTimeState();
  
get systemTime => null;
}

final class SystemTimeLoading extends SystemTimeState {
  const SystemTimeLoading();
  @override
  List<Object?> get props => [];
}

final class SystemTimeFailure extends SystemTimeState {
  final DioException? error;
  const SystemTimeFailure({this.error});

  @override
  List<Object?> get props => [error];
}

final class SystemTimeSuccess extends SystemTimeState {
  @override
  final SystemTimeModel? systemTime;

  const SystemTimeSuccess({this.systemTime});

  @override
  List<Object?> get props => [systemTime];
}

