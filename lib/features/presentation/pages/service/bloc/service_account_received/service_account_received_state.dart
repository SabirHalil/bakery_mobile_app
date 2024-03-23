part of 'service_account_received_bloc.dart';
@immutable
sealed class ServiceAccountReceivedState {
  const ServiceAccountReceivedState();
   get serviceAccountReceived => null;
}

final class ServiceAccountReceivedLoading extends ServiceAccountReceivedState {
  const ServiceAccountReceivedLoading();
}

final class ServiceAccountReceivedFailure extends ServiceAccountReceivedState {
  final String? error;
  const ServiceAccountReceivedFailure({this.error});
}

final class ServiceAccountReceivedSuccess extends ServiceAccountReceivedState {
  
  @override
  final List<ServiceAccountReceivedModel>? serviceAccountReceived;
  const ServiceAccountReceivedSuccess({this.serviceAccountReceived});
}