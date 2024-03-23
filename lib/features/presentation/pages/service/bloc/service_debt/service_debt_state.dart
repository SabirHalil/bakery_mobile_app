part of 'service_debt_bloc.dart';

@immutable
sealed class ServiceDebtState {
  const ServiceDebtState();
  get serviceTotalDebtList => null;

}

final class ServiceDebtLoading extends ServiceDebtState {
  const ServiceDebtLoading();
}

final class ServiceDebtFailure extends ServiceDebtState {
  final String? error;
  const ServiceDebtFailure({this.error});
}

final class ServiceTotalDebtSuccess extends ServiceDebtState {
  @override
  final List<ServiceDebtTotalModel>? serviceTotalDebtList;
  
  const ServiceTotalDebtSuccess(
      {this.serviceTotalDebtList});
}


