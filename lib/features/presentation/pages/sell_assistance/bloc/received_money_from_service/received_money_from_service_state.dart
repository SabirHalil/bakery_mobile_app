part of 'received_money_from_service_bloc.dart';
@immutable
sealed class ReceivedMoneyFromServiceState{
  const ReceivedMoneyFromServiceState();
  
 get receivedMoneyFromService => null;
}

final class ReceivedMoneyFromServiceLoading extends ReceivedMoneyFromServiceState {
  const ReceivedMoneyFromServiceLoading();
}

final class ReceivedMoneyFromServiceFailure extends ReceivedMoneyFromServiceState {
  final String? error;
  const ReceivedMoneyFromServiceFailure({this.error});
}

final class ReceivedMoneyFromServiceSuccess extends ReceivedMoneyFromServiceState {
  
  @override
  final ReceivedMoneyFromServiceModel? receivedMoneyFromService;
  
  const ReceivedMoneyFromServiceSuccess({this.receivedMoneyFromService});
}

