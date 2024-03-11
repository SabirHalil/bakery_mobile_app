part of 'dough_products_process_bloc.dart';

sealed class DoughProductsProcessEvent {}

final class GetDoughProductsRequested extends DoughProductsProcessEvent {}

final class AddDoughProductRequested extends DoughProductsProcessEvent {
  DoughProductProcessModel product;
  AddDoughProductRequested({required this.product});
}

final class UpdateDoughProductRequested extends DoughProductsProcessEvent {
    DoughProductProcessModel product;
  UpdateDoughProductRequested({required this.product});
}
