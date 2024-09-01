
import '../../../core/resources/data_state.dart';
import '../entities/accumulated_money.dart';
import '../repositories/accumulated_credit_cart_repository.dart';

class AccumulatedCreditCardUseCase {
  final AccumulatedCreditCardRepositroy _accumulatedCreditCardRepositroy;
  AccumulatedCreditCardUseCase(this._accumulatedCreditCardRepositroy);

  Future<DataState<AccumulatedMoneyEntity?>> getAccumulatedCreditCardByDate(
      DateTime date) async {
    return _accumulatedCreditCardRepositroy.getAccumulatedCreditCardByDate(date);
  }

  Future<DataState<List<AccumulatedMoneyEntity>?>>
      getAccumulatedCreditCardListByDateRange(
          DateTime startDate, DateTime endDate) async {
    return _accumulatedCreditCardRepositroy.getAccumulatedCreditCardListByDateRange(
        startDate, endDate);
  }

  Future<DataState<void>> addAccumulatedCreditCard(
      AccumulatedMoneyEntity creditCardCounting) async {
    return _accumulatedCreditCardRepositroy.addAccumulatedCreditCard(creditCardCounting);
  }

  Future<DataState<void>> updateAccumulatedCreditCard(
      AccumulatedMoneyEntity creditCardCounting) async {
    return _accumulatedCreditCardRepositroy.updateAccumulatedCreditCard(creditCardCounting);
  }
}