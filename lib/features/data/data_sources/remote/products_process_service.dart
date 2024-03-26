import 'package:bakery_app/features/data/models/product_process.dart';
import 'package:dio/dio.dart';

import '../../models/dough_product_process.dart';

class ProductsProcessService {
    Dio dio;
  ProductsProcessService(this.dio);

  Future<Response> getAllProductsByCategoryId(
      int categoryId) async {
    return dio.get(
      '/api/Product/GetAllProductsBycategoryId',
      queryParameters: {'categoryId': categoryId}
    );
  }

  Future<Response> addProduct(ProductProcessModel product) async {
    return dio.post(
      '/api/Product/AddProduct',
      data: product.toJson()
    );
  }

  Future<Response> updateProduct(ProductProcessModel product) async {
    return dio.put(
      '/api/Product/UpdateProduct',
      data: product.toJson()
    );
  }

  Future<Response> getAllDoughProducts() async {
    return dio.get('/api/DoughFactoryProduct/GetDoughFactoryProducts');
  }

  Future<Response> addDoughProduct(DoughProductProcessModel doughProduct) async {
    return dio.post(
      '/api/DoughFactoryProduct/AddDoughFactoryProduct',
      data: doughProduct.toJson()
    );
  }

  Future<Response> updateDoughProduct(DoughProductProcessModel doughProduct) async {
    return dio.put(
      '/api/DoughFactoryProduct/UpdateDoughFactoryProduct',
      data: doughProduct.toJson()
    );
  }
}
