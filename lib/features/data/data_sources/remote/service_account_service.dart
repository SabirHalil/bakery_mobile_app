
import 'package:dio/dio.dart';
import '../../models/service_account_to_receive.dart';

class ServiceAccountService {
    Dio dio;
  ServiceAccountService(this.dio);

  Future<Response> getServiceAccountReceivedByDate(DateTime date) async {
    return dio.get(
        '/api/MoneyReceivedFromMarket/GetMoneyReceivedMarketListByDate',
        queryParameters: {'date': date});
  }

  Future<Response> getServiceAccountLeftByDate(DateTime date) async {
    return dio.get(
        '/api/MoneyReceivedFromMarket/GetNotMoneyReceivedMarketListByDate',
        queryParameters: {'date': date});
  }

  Future<Response> addServiceAccountReceived(
      ServiceAccountToReceiveModel serviceAccountReceivedModel) async {
    return dio.post(
        '/api/MoneyReceivedFromMarket/AddMoneyReceivedFromMarket',
        data: serviceAccountReceivedModel.toJson());
  }

  Future<Response> deleteServiceAccountReceived(
      ServiceAccountToReceiveModel serviceAccountReceivedModel) async {
    return dio.delete(
        '/api/MoneyReceivedFromMarket/DeleteMoneyReceivedFromMarket',
        data: serviceAccountReceivedModel.toJson());
  }

  Future<Response> updateServiceAccountReceived(
      ServiceAccountToReceiveModel serviceAccountReceivedModel) async {
    return dio.put(
        '/api/MoneyReceivedFromMarket/UpdateMoneyReceivedFromMarket',
        data: serviceAccountReceivedModel.toJson());
  }
}

