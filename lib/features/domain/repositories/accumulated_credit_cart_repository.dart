import 'package:bakery_app/features/domain/entities/accumulated_money.dart';

import '../../../core/resources/data_state.dart';

abstract class AccumulatedCreditCardRepositroy{
  Future<DataState<AccumulatedMoneyEntity?>> getAccumulatedCreditCardByDate(DateTime date);
  Future<DataState<List<AccumulatedMoneyEntity>?>> getAccumulatedCreditCardListByDateRange(DateTime startDate, DateTime endDate);
  Future<DataState<void>> addAccumulatedCreditCard(AccumulatedMoneyEntity accumulatedCreditCard);
  Future<DataState<void>> updateAccumulatedCreditCard(AccumulatedMoneyEntity accumulatedCreditCard);
}