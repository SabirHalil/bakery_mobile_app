import 'package:dio/dio.dart';
import '../../models/stale_product_to_add.dart';

class StaleProductService {
  Dio dio;
  StaleProductService(this.dio);
  Future<Response> getAddedStaleProductListByDate(
      DateTime date, int categoryId) async {
    return dio.get('/api/StaleProduct/GetByDateAndCategory',
        queryParameters: {'date': date, 'categoryId': categoryId});
  }

  Future<Response> getProductListByDate(DateTime date, int categoryId) async {
    return dio.get('/api/StaleProduct/GetProductsNotAddedToStale',
        queryParameters: {'date': date, 'categoryId': categoryId});
  }

  Future<Response> addStaleProduct(
      StaleProductToAddModel staleProductToAdd) async {
    return dio.post('/api/StaleProduct/AddStaleProduct',
        data: staleProductToAdd.toJson());
  }

  Future<Response> deleteStaleProduct(int id) async {
    return dio.delete('/api/StaleProduct/DeleteStaleProduct',
        queryParameters: {'id': id});
  }

  Future<Response> updateStaleProduct(
      StaleProductToAddModel staleProductToAdd) async {
    return dio.put('/api/StaleProduct/UpdateStaleProduct',
        data: staleProductToAdd.toJson());
  }
}
