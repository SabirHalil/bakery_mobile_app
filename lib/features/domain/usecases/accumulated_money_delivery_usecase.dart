import '../../../core/resources/data_state.dart';
import '../entities/accumulated_money_delivery.dart';
import '../repositories/accumulated_money_delivery_repository.dart';

class AccumulatedMoneyDeliveryUseCase {
  final AccumulatedMoneyDeliveryRepositroy _accumulatedMoneyDeliveryRepositroy;
  AccumulatedMoneyDeliveryUseCase(this._accumulatedMoneyDeliveryRepositroy);

  Future<DataState<double?>>
      getAccumulatedCash() async {
    return _accumulatedMoneyDeliveryRepositroy
        .getAccumulatedCash();
  }

  Future<DataState<List<AccumulatedMoneyDeliveryEntity>?>>
      getAccumulatedMoneyDeliveryListByDateRange(
          DateTime startDate, DateTime endDate) async {
    return _accumulatedMoneyDeliveryRepositroy
        .getAccumulatedMoneyDeliveryListByDateRange(startDate, endDate);
  }

  Future<DataState<void>> addAccumulatedMoneyDelivery(
      AccumulatedMoneyDeliveryEntity moneyDeliveryCounting) async {
    return _accumulatedMoneyDeliveryRepositroy
        .addAccumulatedMoneyDelivery(moneyDeliveryCounting);
  }

  Future<DataState<void>> updateAccumulatedMoneyDelivery(
      AccumulatedMoneyDeliveryEntity moneyDeliveryCounting) async {
    return _accumulatedMoneyDeliveryRepositroy
        .updateAccumulatedMoneyDelivery(moneyDeliveryCounting);
  }
}
