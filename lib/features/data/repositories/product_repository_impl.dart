// ignore_for_file: void_checks, depend_on_referenced_packages

import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/product_service.dart';
import 'package:bakery_app/features/data/models/product_to_add.dart';
import 'package:bakery_app/features/domain/entities/added_product.dart';
import 'package:bakery_app/features/domain/entities/product.dart';
import 'package:bakery_app/features/domain/entities/product_to_add.dart';
import 'package:bakery_app/features/domain/repositories/product_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/show_snake_bar.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductApiService _apiService;
  ProductRepositoryImpl(this._apiService);
  @override
  Future<DataState<String>> addProducts(
      int userId, int categoryId, List<ProductToAddEntity> productList,DateTime date) async {
    try {
      final List<ProductToAddModel> productModel =
          productList.map((e) => ProductToAddModel.fromEntity(e)).toList();
      final httpResponse =
          await _apiService.addProducts(userId: userId,categoryId: categoryId,doughListProduct: productModel,date: date);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              requestOptions: httpResponse.response.requestOptions),
        );
      }
    } catch (e) {
          showSnakeBar(e.toString(), null, null);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> deleteProductById(int id)async {
     try {
      final httpResponse = await _apiService.deleteProductById(id: id);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              requestOptions: httpResponse.response.requestOptions),
        );
      }
    } catch (e) {
          showSnakeBar(e.toString(), null, null);
      rethrow;
    }
  }

  @override
  Future<DataState<List<AddedProductEntity>>>
      getAddedProductsByDateAndCategoryId(DateTime date, int categoryId)async {
   try {
      final httpResponse = await _apiService.getAddedProductsByDateAndCategoryId(date: date,categoryId: categoryId);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              requestOptions: httpResponse.response.requestOptions),
        );
      }
    } catch (e) {
          showSnakeBar(e.toString(), null, null);
      rethrow;
    }
  }

  @override
  Future<DataState<List<ProductEntity>>> getAvailableProductsByCategoryId(
      DateTime date, int categoryId)async {
  try {
      final httpResponse = await _apiService.getAvailableProductsByCategoryId(date: date,categoryId: categoryId);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              requestOptions: httpResponse.response.requestOptions),
        );
      }
    } catch (e) {
          showSnakeBar(e.toString(), null, null);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> updateProduct(ProductToAddEntity product)async {
  try {
      final httpResponse = await _apiService.updateProduct(product: ProductToAddModel.fromEntity(product));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              requestOptions: httpResponse.response.requestOptions),
        );
      }
    } catch (e) {
          showSnakeBar(e.toString(), null, null);
      rethrow;
    }
  }
}
