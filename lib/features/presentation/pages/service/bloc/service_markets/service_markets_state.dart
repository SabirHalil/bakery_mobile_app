part of 'service_markets_bloc.dart';

@immutable
sealed class ServiceMarketsState extends Equatable {
  const ServiceMarketsState();
  get markets => null;
}

final class ServiceMarketsLoading extends ServiceMarketsState {
  const ServiceMarketsLoading();
  @override
  List<Object?> get props => [];
}

final class ServiceMarketsFailure extends ServiceMarketsState {
  final DioException? error;
  const ServiceMarketsFailure({this.error});
  @override
  List<Object?> get props => [error];
}

final class ServiceMarketsSuccess extends ServiceMarketsState {
  @override
  final List<ServiceMarketModel>? markets;
  const ServiceMarketsSuccess({this.markets});
  @override
  List<Object?> get props => [markets];
}
