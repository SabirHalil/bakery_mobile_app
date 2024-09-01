import 'package:bakery_app/features/domain/repositories/accumulated_cash_repository.dart';

import '../../../core/resources/data_state.dart';
import '../entities/accumulated_money.dart';

class AccumulatedCashUseCase {
  final AccumulatedCashRepositroy _accumulatedCashRepositroy;
  AccumulatedCashUseCase(this._accumulatedCashRepositroy);

  Future<DataState<AccumulatedMoneyEntity?>> getAccumulatedCashByDate(
      DateTime date) async {
    return _accumulatedCashRepositroy.getAccumulatedCashByDate(date);
  }

  Future<DataState<List<AccumulatedMoneyEntity>?>>
      getAccumulatedCashListByDateRange(
          DateTime startDate, DateTime endDate) async {
    return _accumulatedCashRepositroy.getAccumulatedCashListByDateRange(
        startDate, endDate);
  }

  Future<DataState<void>> addAccumulatedCash(
      AccumulatedMoneyEntity cashCounting) async {
    return _accumulatedCashRepositroy.addAccumulatedCash(cashCounting);
  }

  Future<DataState<void>> updateAccumulatedCash(
      AccumulatedMoneyEntity cashCounting) async {
    return _accumulatedCashRepositroy.updateAccumulatedCash(cashCounting);
  }
}
