part of 'service_product_bloc.dart';
@immutable
sealed class ServiceProductsState {
  const ServiceProductsState();

}

final class ServiceProductsLoading extends ServiceProductsState {
  const ServiceProductsLoading();

}

final class ServiceProductsFailure extends ServiceProductsState {
  final String? error;
  const ServiceProductsFailure({this.error});

}

final class ServiceProductsSuccess extends ServiceProductsState {
  final List<ServiceProductModel>? serviceProductsList;

  const ServiceProductsSuccess({this.serviceProductsList});

}

