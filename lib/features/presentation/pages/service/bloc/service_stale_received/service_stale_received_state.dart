part of 'service_stale_received_bloc.dart';

sealed class ServiceStaleReceivedState {
  const ServiceStaleReceivedState();
get serviceReceivedStale => null;
}

final class ServiceStaleReceivedLoading extends ServiceStaleReceivedState {
  const ServiceStaleReceivedLoading();
}

final class ServiceStaleReceivedFailure extends ServiceStaleReceivedState {
  final String? error;
  const ServiceStaleReceivedFailure({this.error});
}

final class ServiceStaleReceivedSuccess extends ServiceStaleReceivedState {
  
  @override
  final List<ServiceReceivedStaleModel>? serviceReceivedStale;
  const ServiceStaleReceivedSuccess({this.serviceReceivedStale});
}
