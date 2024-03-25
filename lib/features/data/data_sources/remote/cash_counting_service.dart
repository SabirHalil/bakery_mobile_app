import 'package:dio/dio.dart';

import '../../models/cash_counting.dart';


class CashCountingService {
    Dio dio;
  CashCountingService(this.dio);

  Future<Response> getCashCountingByDate(DateTime date) async {
    return await dio.get('/api/CashCounting/GetCashCountingByDate',
        queryParameters: {'date': date});
  }

  Future<Response> addCashCounting(CashCountingModel cashCounting) async {
    return await dio.post('/api/CashCounting/AddCashCounting',
        data: cashCounting.toJson());
  }

  Future<Response> deleteCashCountingById(int id) async {
    return await dio.delete('/api/CashCounting/DeleteCashCountingById',
        queryParameters: {'id': id});
  }

  Future<Response> updateCashCounting(CashCountingModel cashCounting) async {
    return dio.put('/api/CashCounting/UpdateCashCounting',
        data: cashCounting.toJson());
  }
}
