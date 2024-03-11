import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/products_process_service.dart';
import 'package:bakery_app/features/data/models/dough_product_process.dart';
import 'package:bakery_app/features/domain/entities/dough_product_process.dart';
import 'package:bakery_app/features/domain/entities/product_process.dart';
import 'package:bakery_app/features/domain/repositories/products_process_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/toast_message.dart';
import '../models/product_process.dart';

class ProductsProcessRepositoryImpl extends ProductsProcessRepository {
  final ProductsProcessService _productsProcessService;
  ProductsProcessRepositoryImpl(this._productsProcessService);

  @override
  Future<DataState<void>> addDoughProduct(DoughProductProcessEntity product)async {
 try {

      final httpResponse =await _productsProcessService.addDoughProduct(DoughProductProcessModel.fromEntity(product));
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
      showToastMessage(e.toString(),duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> addProduct(ProductProcessEntity product)async {
    try {

      final httpResponse =
          await _productsProcessService.addProduct(ProductProcessModel.fromEntity(product));
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
      showToastMessage(e.toString(),duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<List<DoughProductProcessEntity>>> getAllDoughProducts()async {
    try {
      final httpResponse = await _productsProcessService.getAllDoughProducts();
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
      showToastMessage(e.toString(),duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<List<ProductProcessEntity>>> getAllProductsByCategoryId(int categoryId)async {
  try {
      final httpResponse = await _productsProcessService.getAllProductsByCategoryId(categoryId);
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
      showToastMessage(e.toString(),duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> updateDoughProduct(DoughProductProcessEntity product)async {
    try {

      final httpResponse =
          await _productsProcessService.updateDoughProduct(DoughProductProcessModel.fromEntity(product));
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
      showToastMessage(e.toString(),duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> updateProduct(ProductProcessEntity product)async {
    try {

      final httpResponse =
          await _productsProcessService.updateProduct(ProductProcessModel.fromEntity(product));
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
      showToastMessage(e.toString(),duration: 1);
      rethrow;
    }
  }
}
