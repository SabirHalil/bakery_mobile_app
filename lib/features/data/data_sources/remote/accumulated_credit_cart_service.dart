import 'package:dio/dio.dart';

import '../../models/accumulated_money.dart';

class AccumulatedCreditCardService {
  Dio dio;
  AccumulatedCreditCardService(this.dio);

    Future<Response> getAccumulatedCreditCardByDate(DateTime date) async {
    return await dio.get('/api/AccumulatedCreditCard/GetAccumulatedCreditCardByDate',
        queryParameters: {'date': date});
  }

  Future<Response> getAccumulatedCreditCardListByDateRange(DateTime startDate, DateTime endDate) async {
    return await dio.get('/api/AccumulatedCreditCard/GetAccumulatedCreditCardByDateRange',
        queryParameters: {'startDate': startDate, 'endDate': endDate});
  }

  Future<Response> addAccumulatedCreditCard(AccumulatedMoneyModel accumulatedMoney) async {
    return await dio.post('/api/AccumulatedCreditCard/AddAccumulatedCreditCard',
        data: accumulatedMoney.toJson());
  }

  Future<Response> updateAccumulatedCreditCard(AccumulatedMoneyModel accumulatedMoney) async {
    return dio.put('/api/AccumulatedCreditCard/UpdateAccumulatedCreditCard',
        data: accumulatedMoney.toJson());
  }
}
