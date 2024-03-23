part of 'dough_products_process_bloc.dart';

@immutable
sealed class DoughProductsProcessState {
  const DoughProductsProcessState();
}

final class DoughProductsProcessLoading extends DoughProductsProcessState {
  const DoughProductsProcessLoading();
}

final class DoughProductsProcessFailure extends DoughProductsProcessState {
  final String? error;
  const DoughProductsProcessFailure({this.error});
}

final class DoughProductsProcessSuccess extends DoughProductsProcessState {
  
  final List<DoughProductProcessModel>? doughProductsProcessList;

  const DoughProductsProcessSuccess({this.doughProductsProcessList});
}
