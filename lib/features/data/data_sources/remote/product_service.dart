import 'package:bakery_app/features/data/models/product_to_add.dart';
import 'package:dio/dio.dart';

class ProductApiService {
   Dio dio;
  ProductApiService(this.dio);

  Future<Response> getAddedProductsByDateAndCategoryId(
      DateTime date, int categoryId) async {
    return dio.get(
      '/api/ProductionList/GetAddedProductsByDateAndCategoryId',
      queryParameters: {'date': date, 'categoryId': categoryId}
    );
  }

  Future<Response> getAvailableProductsByCategoryId(
      DateTime date, int categoryId) async {
    return dio.get(
      '/api/ProductionList/GetNotAddedProductsByListAndCategoryId',
      queryParameters: {'date': date, 'categoryId': categoryId}
    );
  }

  Future<Response> addProducts(int userId, int categoryId,
      List<ProductToAddModel> doughListProduct, DateTime date) async {
    return dio.post(
      '/api/ProductionList/AddProductionListAndDetail',
      queryParameters: {'userId': userId, 'categoryId': categoryId, 'date': date},
      data: doughListProduct.map((e) => e.toJson()).toList()
    );
  }

  Future<Response> deleteProductById(int id) async {
    return dio.delete(
      '/api/ProductionList/DeleteProductionListDetail',
      queryParameters: {'id': id}
    );
  }

  Future<Response> updateProduct(ProductToAddModel product) async {
    return dio.put(
      '/api/ProductionList/UpdateProductionListDetail',
      data: product.toJson()
    );
  }
}
