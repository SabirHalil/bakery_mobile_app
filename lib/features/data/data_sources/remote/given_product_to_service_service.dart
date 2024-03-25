import 'package:bakery_app/features/data/models/given_product_to_service.dart';
import 'package:dio/dio.dart';

class GivenProductToService {
    Dio dio;
  GivenProductToService(this.dio);

  Future<Response> getGivenProductToServiceListByDateAndServiceType(
    DateTime date,
    int servisTypeId,
  ) async {
    return await dio.get(
      '/api/GivenProductsToService/GetGivenProductsToServiceByDateAndServisTypeId',
      queryParameters: {'date': date, 'servisTypeId': servisTypeId},
    );
  }

  Future<Response> addGivenProductToService(
    GivenProductToServiceModel givenProductToService,
  ) async {
    return await dio.post(
      '/api/GivenProductsToService/AddGivenProductsToService',
      data: givenProductToService.toJson(),
    );
  }

  Future<Response> deleteGivenProductToService(int id) async {
    return await dio.delete(
      '/api/GivenProductsToService/DeleteGivenProductsToService',
      queryParameters: {'id': id},
    );
  }

  Future<Response> updateGivenProductToService(
    GivenProductToServiceModel givenProductToService,
  ) async {
    return await dio.put(
      '/api/GivenProductsToService/UpdateGivenProductsToService',
      data: givenProductToService.toJson(),
    );
  }
}
