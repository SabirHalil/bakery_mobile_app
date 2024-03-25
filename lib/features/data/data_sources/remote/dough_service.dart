import 'package:bakery_app/features/data/models/dough_product_to_add.dart';
import 'package:dio/dio.dart';


class DoughApiService {
    Dio dio;
  DoughApiService(this.dio);


  Future<Response> getListsByDate(
      DateTime date) async {
    return dio.get('/api/DoughFactory/GetByDateDoughFactoryList',
        queryParameters: {'date': date});
  }

  Future<Response> addDoughProducts(
    int userId,
    List<DoughProductToAddModel> doughListProduct,
    DateTime date,
  ) async {
    return dio.post('/api/DoughFactory/AddDoughFactoryListAndListDetail',
        queryParameters: {'userId': userId, 'date': date},
        data: doughListProduct.map((e) => e.toJson()).toList());
  }

  Future<Response> getAddedProductsByListId(int doughFactoryListId) async {
    return dio.get('/api/DoughFactory/GetAddedDoughFactoryListDetailByListId',
        queryParameters: {'doughFactoryListId': doughFactoryListId});
  }

  Future<Response> getAvailableProductsByListId(int listId) async {
    return dio.get(
        '/api/DoughFactory/GetNotAddedDoughFactoryListDetailByListId',
        queryParameters: {'doughFactoryListId': listId});
  }

  Future<Response> deleteProductFromList(int id) async {
    return dio.delete('/api/DoughFactory/DeleteDoughFactoryListDetail',
        queryParameters: {'id': id});
  }

  Future<Response> updateProductFromList(
   DoughProductToAddModel doughListProduct) async {
    return dio.put('/api/DoughFactory/UpdateDoughFactoryListDetail',
        data: doughListProduct.toJson());
  }
}
