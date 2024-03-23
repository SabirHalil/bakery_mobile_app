part of 'service_stale_product_bloc.dart';

sealed class ServiceStaleProductState{
  const ServiceStaleProductState();
  
 get serviceStaleProductList => null;
}

final class ServiceStaleProductLoading extends ServiceStaleProductState {
  const ServiceStaleProductLoading();
}

final class ServiceStaleProductFailure extends ServiceStaleProductState {
  final String? error;
  const ServiceStaleProductFailure({this.error});
}

final class ServiceStaleProductSuccess extends ServiceStaleProductState {
  
  @override
  final List<ServiceStaleProductModel>? serviceStaleProductList;
  
  const ServiceStaleProductSuccess(
      {this.serviceStaleProductList});
}

