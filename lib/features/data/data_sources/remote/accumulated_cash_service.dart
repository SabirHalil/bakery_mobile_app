import 'package:dio/dio.dart';

import '../../models/accumulated_money.dart';

class AccumulatedCashService {
  Dio dio;
  AccumulatedCashService(this.dio);

    Future<Response> getAccumulatedCashByDate(DateTime date) async {
    return await dio.get('/api/AccumulatedCash/GetAccumulatedCashAmountByDate',
        queryParameters: {'date': date});
  }

  Future<Response> getAccumulatedCashListByDateRange(DateTime startDate, DateTime endDate) async {
    return await dio.get('/api/AccumulatedCash/GetAccumulatedCashByDateRange',
        queryParameters: {'startDate': startDate, 'endDate': endDate});
  }

  Future<Response> addAccumulatedCash(AccumulatedMoneyModel accumulatedMoney) async {
    return await dio.post('/api/AccumulatedCash/AddAccumulatedCash',
        data: accumulatedMoney.toJson());
  }

  Future<Response> updateAccumulatedCash(AccumulatedMoneyModel accumulatedMoney) async {
    return dio.put('/api/AccumulatedCash/UpdateAccumulatedCash',
        data: accumulatedMoney.toJson());
  }
}
