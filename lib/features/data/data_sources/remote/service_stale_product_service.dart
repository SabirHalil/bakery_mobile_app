import 'package:dio/dio.dart';
import '../../models/service_stale_product.dart';

class ServiceStaleProduct {
    Dio dio;
  ServiceStaleProduct(this.dio);

  Future<Response> getServiceStaleProductListByDateAndServiceType(
      DateTime date, int serviceTypeId) async {
    return dio.get(
        '/api/ServiceStaleProduct/GetServiceStaleProductListByDateAndServiceTypeId',
        queryParameters: {'date': date, 'serviceTypeId': serviceTypeId});
  }

  Future<Response> addServiceStaleProduct(
      ServiceStaleProductModel serviceStaleProduct) async {
    return dio.post('/api/ServiceStaleProduct/AddServiceStaleProduct',
        data: serviceStaleProduct.toJson());
  }

  Future<Response> deleteServiceStaleProduct(int id) async {
    return dio.delete('/api/ServiceStaleProduct/DeleteServiceStaleProduct',
        queryParameters: {'id': id});
  }

  Future<Response> updateServiceStaleProduct(
      ServiceStaleProductModel serviceStaleProduct) async {
    return dio.put('/api/ServiceStaleProduct/UpdateServiceStaleProduct',
        data: serviceStaleProduct.toJson());
  }
}

