part of 'service_lists_bloc.dart';

@immutable
sealed class ServiceListsState {
  const ServiceListsState();

  get serviceLists => null;
}

final class ServiceListsLoading extends ServiceListsState {
  const ServiceListsLoading();
}

final class ServiceListsFailure extends ServiceListsState {
  final String? error;
  const ServiceListsFailure({this.error});
}

final class ServiceListsSuccess extends ServiceListsState {
  @override
  final List<ServiceListModel>? serviceLists;
  const ServiceListsSuccess({this.serviceLists});
}
