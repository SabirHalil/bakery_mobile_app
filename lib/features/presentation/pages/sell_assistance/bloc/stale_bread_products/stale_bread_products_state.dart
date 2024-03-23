part of 'stale_bread_products_bloc.dart';
@immutable
sealed class StaleBreadProductsState{
  const StaleBreadProductsState();
  
get staleBreadProductsList => null;
}

final class StaleBreadProductsLoading extends StaleBreadProductsState {
  const StaleBreadProductsLoading();
}

final class StaleBreadProductsFailure extends StaleBreadProductsState {
  final String? error;
  const StaleBreadProductsFailure({this.error});
}

final class StaleBreadProductsSuccess extends StaleBreadProductsState {
  
  @override
  final List<StaleBreadModel>? staleBreadProductsList;
  const StaleBreadProductsSuccess({this.staleBreadProductsList});
}
