part of 'service_stale_left_bloc.dart';

sealed class ServiceStaleLeftState{
  const ServiceStaleLeftState();
  get serviceStaleLeft => null;
}

final class ServiceStaleLeftLoading extends ServiceStaleLeftState {
  const ServiceStaleLeftLoading();
}

final class ServiceStaleLeftFailure extends ServiceStaleLeftState {
  final String? error;
  const ServiceStaleLeftFailure({this.error});
}

final class ServiceStaleLeftSuccess extends ServiceStaleLeftState {
  @override
  final List<ServiceStaleModel>? serviceStaleLeft;
  const ServiceStaleLeftSuccess({this.serviceStaleLeft});
}
