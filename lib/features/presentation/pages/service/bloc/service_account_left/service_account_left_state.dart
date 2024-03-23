part of 'service_account_left_bloc.dart';

@immutable
sealed class ServiceAccountLeftState {
  const ServiceAccountLeftState();
  get serviceAccountLeft => null;
}

final class ServiceAccountLeftLoading extends ServiceAccountLeftState {
  const ServiceAccountLeftLoading();
}

final class ServiceAccountLeftFailure extends ServiceAccountLeftState {
  final String? error;
  const ServiceAccountLeftFailure({this.error});
}

final class ServiceAccountLeftSuccess extends ServiceAccountLeftState {
  @override
  final List<ServiceAccountLeftModel>? serviceAccountLeft;
  const ServiceAccountLeftSuccess({this.serviceAccountLeft});
}
