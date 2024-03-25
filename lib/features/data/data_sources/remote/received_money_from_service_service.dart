import 'package:dio/dio.dart';
import '../../models/received_money_from_service.dart';

class ReceivedMoneyFromService {
    Dio dio;
  ReceivedMoneyFromService(this.dio);

  Future<Response> getReceivedMoneyFromServiceByDateAndServiceType(
      DateTime date, int serviceType) async {
    return dio.get(
      '/api/ReceivedMoneyFromService/GetReceivedMoneyFromServiceByDateAndServiceType',
      queryParameters: {'date': date, 'serviceType': serviceType},
    );
  }

  Future<Response> addReceivedMoneyFromService(
      ReceivedMoneyFromServiceModel receivedMoneyFromService) async {
    return dio.post(
      '/api/ReceivedMoneyFromService/AddReceivedMoneyFromService',
      data: receivedMoneyFromService.toJson(),
    );
  }

  Future<Response> deleteReceivedMoneyFromServiceById(int id) async {
    return dio.delete(
      '/api/ReceivedMoneyFromService/DeleteReceivedMoneyFromServiceById',
      queryParameters: {'id': id},
    );
  }

  Future<Response> updateReceivedMoneyFromService(
      ReceivedMoneyFromServiceModel receivedMoneyFromService) async {
    return dio.put(
      '/api/ReceivedMoneyFromService/UpdateReceivedMoneyFromService',
      data: receivedMoneyFromService.toJson(),
    );
  }
}
