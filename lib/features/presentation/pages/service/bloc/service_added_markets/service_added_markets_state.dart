part of 'service_added_markets_bloc.dart';

@immutable
sealed class ServiceAddedMarketsState{
  const ServiceAddedMarketsState();
  get serviceAddedMarkets => null;
   get listId => null;
}

final class ServiceAddedMarketsLoading extends ServiceAddedMarketsState {
  const ServiceAddedMarketsLoading();
}

final class ServiceAddedMarketsFailure extends ServiceAddedMarketsState {
  final String? error;
  const ServiceAddedMarketsFailure({this.error});
}

final class ServiceAddedMarketsSuccess extends ServiceAddedMarketsState {
  @override
  final List<ServiceAddedMarketModel>? serviceAddedMarkets;
  @override
  final int? listId;
  const ServiceAddedMarketsSuccess({this.serviceAddedMarkets, this.listId});
}
