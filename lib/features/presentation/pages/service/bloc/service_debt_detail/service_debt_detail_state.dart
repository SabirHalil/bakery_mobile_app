part of 'service_debt_detail_bloc.dart';

@immutable
sealed class ServiceDebtDetailState{
  const ServiceDebtDetailState();
  get serviceDebtDetailList => null;
}

final class ServiceDebtDetailLoading extends ServiceDebtDetailState {
  const ServiceDebtDetailLoading();
}

final class ServiceDebtDetailFailure extends ServiceDebtDetailState {
  final String? error;
  const ServiceDebtDetailFailure({this.error});
}

final class ServiceDebtDetailSuccess extends ServiceDebtDetailState {

  @override
  final List<ServiceDebtDetailModel>? serviceDebtDetailList;
  const ServiceDebtDetailSuccess(
      {this.serviceDebtDetailList});
}


