import 'package:bakery_app/features/domain/entities/accumulated_money.dart';

import '../../../core/resources/data_state.dart';

abstract class AccumulatedCashRepositroy{
  Future<DataState<AccumulatedMoneyEntity?>> getAccumulatedCashByDate(DateTime date);
  Future<DataState<List<AccumulatedMoneyEntity>?>> getAccumulatedCashListByDateRange(DateTime startDate, DateTime endDate);
  Future<DataState<void>> addAccumulatedCash(AccumulatedMoneyEntity accumulatedCash);
  Future<DataState<void>> updateAccumulatedCash(AccumulatedMoneyEntity accumulatedCash);
}