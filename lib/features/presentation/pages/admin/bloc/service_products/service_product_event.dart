part of 'service_product_bloc.dart';

sealed class ServiceProductsEvent{}

final class GetServiceProductsRequested extends ServiceProductsEvent {}

final class AddServiceProductRequested extends ServiceProductsEvent {
  ServiceProductModel product;
  AddServiceProductRequested({required this.product});
}

final class UpdateServiceProductRequested extends ServiceProductsEvent {
    ServiceProductModel product;
  UpdateServiceProductRequested({required this.product});
}
