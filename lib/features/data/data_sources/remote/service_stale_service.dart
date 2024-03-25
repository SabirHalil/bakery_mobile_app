import 'package:dio/dio.dart';
import '../../models/service_to_receive_stale.dart';

class ServiceStaleService {
    Dio dio;
  ServiceStaleService(this.dio);

  Future<Response> getServiceReceivedStaleByDate(DateTime date) async {
    return dio.get(
        '/api/StaleBreadReceivedFromMarket/GetStaleBreadReceivedFromMarketByDate',
        queryParameters: {'date': date});
  }

  Future<Response> getServiceNotReceivedStaleByDate(DateTime date) async {
    return dio.get(
        '/api/StaleBreadReceivedFromMarket/GetNoBreadReceivedMarketListByDate',
        queryParameters: {'date': date});
  }

  Future<Response> addServiceReceivedStale(
      ServiceToReceiveStaleModel serviceToReceiveStaleModel) async {
    return dio.post(
        '/api/StaleBreadReceivedFromMarket/AddStaleBreadReceivedFromMarket',
        data: serviceToReceiveStaleModel.toJson());
  }

  Future<Response> deleteServiceReceivedStale(int id) async {
    return dio.delete(
        '/api/StaleBreadReceivedFromMarket/DeleteStaleBreadReceivedFromMarketById',
        queryParameters: {'id': id});
  }

  Future<Response> updateServiceReceivedStale(
      ServiceToReceiveStaleModel serviceToReceiveStaleModel) async {
    return dio.put(
        '/api/StaleBreadReceivedFromMarket/UpdateStaleBreadReceivedFromMarket',
        data: serviceToReceiveStaleModel.toJson());
  }
}
