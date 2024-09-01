import 'package:dio/dio.dart';

import '../../models/accumulated_money_delivery.dart';

class AccumulatedMoneyDeliveryService {
  Dio dio;
  AccumulatedMoneyDeliveryService(this.dio);

    Future<Response> getAccumulatedCash() async {
    return await dio.get('/api/AccumulatedMoneyDelivery/GetAccumulatedCash',);
  }

  Future<Response> getAccumulatedMoneyDeliveryListByDateRange(DateTime startDate, DateTime endDate) async {
    return await dio.get('/api/AccumulatedMoneyDelivery/GetAccumulatedMoneyDeliveryByDateRange',
        queryParameters: {'startDate': startDate, 'endDate': endDate});
  }

  Future<Response> addAccumulatedMoneyDelivery(AccumulatedMoneyDeliveryModel accumulatedMoneyDelivery) async {
    return await dio.post('/api/AccumulatedMoneyDelivery/AddAccumulatedMoneyDelivery',
        data: accumulatedMoneyDelivery.toJson());
  }

  Future<Response> updateAccumulatedMoneyDelivery(AccumulatedMoneyDeliveryModel accumulatedMoneyDelivery) async {
    return dio.put('/api/AccumulatedMoneyDelivery/UpdateAccumulatedMoneyDelivery',
        data: accumulatedMoneyDelivery.toJson());
  }
}
