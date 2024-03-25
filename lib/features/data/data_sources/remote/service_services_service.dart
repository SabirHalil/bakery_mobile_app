import 'package:bakery_app/features/data/models/service_market_to_add.dart';
import 'package:dio/dio.dart';


class ServiceServicesApiService {
    Dio dio;
  ServiceServicesApiService(this.dio);

  Future<Response> getServiceServicesByDate(DateTime date) async {
    return dio.get('/api/Service/GetByDateServiceList',
        queryParameters: {'date': date});
  }

  Future<Response> addServiceMarkets(int userId, List<ServiceMarketToAddModel> marketList) async {
    return dio.post('/api/Service/AddServiceListAndListDetail',
        queryParameters: {'userId': userId},
        data: marketList.map((e) => e.toJson()).toList());
  }

  Future<Response> getAddedMarketsByListId(int listId) async {
    return dio.get('/api/Service/GetAddedMarketByServiceListId',
        queryParameters: {'listId': listId});
  }

  Future<Response> getAvailableMarketsByListId(int listId) async {
    return dio.get('/api/Service/GetMarketByServiceListId',
        queryParameters: {'listId': listId});
  }

  Future<Response> deleteMarketFromList(int id) async {
    return dio.delete('/api/Service/DeleteServiceListDetail',
        queryParameters: {'id': id});
  }

  Future<Response> updateMarketFromList(ServiceMarketToAddModel doughListProduct) async {
    return dio.put('/api/Service/UpdateServiceListDetail',
        data: doughListProduct.toJson());
  }
}
