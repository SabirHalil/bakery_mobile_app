import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/core/utils/show_snake_bar.dart';
import 'package:bakery_app/features/data/data_sources/remote/stale_product_service.dart';
import 'package:bakery_app/features/data/models/stale_product_to_add.dart';
import 'package:bakery_app/features/domain/entities/stale_product_added.dart';
import 'package:bakery_app/features/domain/entities/stale_product_to_add.dart';
import 'package:bakery_app/features/domain/repositories/stale_product_repository.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/product_not_added.dart';

class StaleProductRepositoryImpl extends StaleProductRepository {
  final StaleProductService _staleProductService;
  StaleProductRepositoryImpl(this._staleProductService);
  @override
  Future<DataState<void>> addStaleProduct(
      StaleProductToAddEntity staleProductToAdd) async {
    try {
      final httpResponse = await _staleProductService.addStaleProduct(
          staleProductToAdd:
              StaleProductToAddModel.fromEntity(staleProductToAdd));
      if (httpResponse.response.statusCode! >= 200 &&
          httpResponse.response.statusCode! <= 300) {
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
  Future<DataState<void>> deleteStaleProduct(int id) async {
    try {
      final httpResponse =
          await _staleProductService.deleteStaleProduct(id: id);
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
  Future<DataState<List<StaleProductAddedEntity>>>
      getAddedStaleProductListByDate(DateTime date, int categoryId) async {
    try {
      final httpResponse = await _staleProductService
          .getAddedStaleProductListByDate(date: date, categoryId: categoryId);
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
      throw e;
    }
  }

  @override
  Future<DataState<List<ProductNotAddedEntity>>> getProductProductListByDate(
      DateTime date, int categoryId) async {
    try {
      final httpResponse = await _staleProductService.getProductListByDate(
          date: date, categoryId: categoryId);
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
  Future<DataState<void>> updateStaleProduct(
      StaleProductToAddEntity staleProductToAdd) async {
    try {
      final httpResponse = await _staleProductService.updateStaleProduct(
          staleProductToAdd:
              StaleProductToAddModel.fromEntity(staleProductToAdd));
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
