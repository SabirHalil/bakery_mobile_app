part of 'service_added_markets_bloc.dart';

@immutable
sealed class ServiceAddedMarketsState extends Equatable {
  const ServiceAddedMarketsState();
  get serviceAddedMarkets => null;
   get listId => null;
}

final class ServiceAddedMarketsLoading extends ServiceAddedMarketsState {
  const ServiceAddedMarketsLoading();
  @override
  List<Object?> get props => [];
}

final class ServiceAddedMarketsFailure extends ServiceAddedMarketsState {
  final DioException? error;
  const ServiceAddedMarketsFailure({this.error});

  @override
  List<Object?> get props => [error];
}

final class ServiceAddedMarketsSuccess extends ServiceAddedMarketsState {
  @override
  final List<ServiceAddedMarketModel>? serviceAddedMarkets;
  @override
  final int? listId;
  const ServiceAddedMarketsSuccess({this.serviceAddedMarkets, this.listId});

  @override
  List<Object?> get props => [serviceAddedMarkets];
}
