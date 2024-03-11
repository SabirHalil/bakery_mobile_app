part of 'dough_products_process_bloc.dart';

@immutable
sealed class DoughProductsProcessState extends Equatable {
  const DoughProductsProcessState();

  get doughProductsProcessList => null;
}

final class DoughProductsProcessLoading extends DoughProductsProcessState {
  const DoughProductsProcessLoading();
  @override
  List<Object?> get props => [];
}

final class DoughProductsProcessFailure extends DoughProductsProcessState {
  final DioException? error;
  const DoughProductsProcessFailure({this.error});

  @override
  List<Object?> get props => [error];
}

final class DoughProductsProcessSuccess extends DoughProductsProcessState {
  @override
  final List<DoughProductProcessModel>? doughProductsProcessList;

  const DoughProductsProcessSuccess({this.doughProductsProcessList});

  @override
  List<Object?> get props => [doughProductsProcessList];
}
