part of 'given_product_to_service_bloc.dart';
@immutable
sealed class GivenProductToServiceState{
  const GivenProductToServiceState();
  get givenProductToServiceList => null;
  
}

final class GivenProductToServiceLoading extends GivenProductToServiceState {
  const GivenProductToServiceLoading();
}

final class GivenProductToServiceFailure extends GivenProductToServiceState {
  final String? error;
  const GivenProductToServiceFailure({this.error});
}

final class GivenProductToServiceSuccess extends GivenProductToServiceState {
  
  @override
  final List<GivenProductToServiceModel>? givenProductToServiceList;
  
  const GivenProductToServiceSuccess(
      {this.givenProductToServiceList});
}
