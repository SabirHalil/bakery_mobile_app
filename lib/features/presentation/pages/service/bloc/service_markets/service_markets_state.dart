part of 'service_markets_bloc.dart';

@immutable
sealed class ServiceMarketsState{
  const ServiceMarketsState();
  get markets => null;
}

final class ServiceMarketsLoading extends ServiceMarketsState {
  const ServiceMarketsLoading();
}

final class ServiceMarketsFailure extends ServiceMarketsState {
  final String? error;
  const ServiceMarketsFailure({this.error});
}

final class ServiceMarketsSuccess extends ServiceMarketsState {
  @override
  final List<ServiceMarketModel>? markets;
  const ServiceMarketsSuccess({this.markets});
}
