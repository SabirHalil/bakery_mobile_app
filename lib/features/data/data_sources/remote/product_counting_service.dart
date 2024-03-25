import 'package:dio/dio.dart';
import '../../models/product_counting_to_add.dart';

class ProductCountingService {
    Dio dio;
  ProductCountingService(this.dio);

  Future<Response> getAddedProductsByDateAndCategoryId(DateTime date, int categoryId) async {
    return dio.get(
      '/api/ProductsCounting/GetProductsCountingByDateAndCategory',
      queryParameters: {'date': date, 'categoryId': categoryId},
    );
  }

  Future<Response> getNotAddedProductsByCategoryId(DateTime date, int categoryId) async {
    return dio.get(
      '/api/ProductsCounting/GetNotAddedProductsCountingByDate',
      queryParameters: {'date': date, 'categoryId': categoryId},
    );
  }

  Future<Response> addProducts(ProductCountingToAddModel product) async {
    return dio.post(
      '/api/ProductsCounting/AddProductsCounting',
      data: product.toJson(),
    );
  }

  Future<Response> deleteProductById(int id) async {
    return dio.delete(
      '/api/ProductsCounting/DeleteProductsCountingById',
      queryParameters: {'id': id},
    );
  }

  Future<Response> updateProduct(ProductCountingToAddModel product) async {
    return dio.put(
      '/api/ProductsCounting/UpdateProductsCounting',
      data: product.toJson(),
    );
  }
}
