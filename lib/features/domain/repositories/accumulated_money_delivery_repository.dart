import '../../../core/resources/data_state.dart';
import '../entities/accumulated_money_delivery.dart';

abstract class AccumulatedMoneyDeliveryRepositroy {
  Future<DataState<double?>>
      getAccumulatedCash();
  Future<DataState<List<AccumulatedMoneyDeliveryEntity>?>>
      getAccumulatedMoneyDeliveryListByDateRange(
          DateTime startDate, DateTime endDate);
  Future<DataState<void>> addAccumulatedMoneyDelivery(
      AccumulatedMoneyDeliveryEntity accumulatedMoneyDelivery);
  Future<DataState<void>> updateAccumulatedMoneyDelivery(
      AccumulatedMoneyDeliveryEntity accumulatedMoneyDelivery);
}
