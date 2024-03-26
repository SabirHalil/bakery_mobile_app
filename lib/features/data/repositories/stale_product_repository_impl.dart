import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/stale_product_service.dart';
import 'package:bakery_app/features/data/models/product_not_added.dart';
import 'package:bakery_app/features/data/models/stale_product_added.dart';
import 'package:bakery_app/features/data/models/stale_product_to_add.dart';
import 'package:bakery_app/features/domain/entities/stale_product_added.dart';
import 'package:bakery_app/features/domain/entities/stale_product_to_add.dart';
import 'package:bakery_app/features/domain/repositories/stale_product_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/product_not_added.dart';

class StaleProductRepositoryImpl extends StaleProductRepository {
  final StaleProductService _staleProductService;
  StaleProductRepositoryImpl(this._staleProductService);
  @override
  Future<DataState<void>> addStaleProduct(
      StaleProductToAddEntity staleProductToAdd) async {
    try {
      final httpResponse = await _staleProductService.addStaleProduct(
          StaleProductToAddModel.fromEntity(staleProductToAdd));
      if (httpResponse.statusCode! >= 200 &&
          httpResponse.statusCode! <= 300) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data));
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> deleteStaleProduct(int id) async {
    try {
      final httpResponse = await _staleProductService.deleteStaleProduct(id);
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
           Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data));
    } catch (e) {
     return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<List<StaleProductAddedEntity>>>
      getAddedStaleProductListByDate(DateTime date, int categoryId) async {
    try {
      final httpResponse = await _staleProductService
          .getAddedStaleProductListByDate(date, categoryId);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<StaleProductAddedEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => StaleProductAddedModel.fromJson(item as Map<String, dynamic>))
          .toList();
        return DataSuccess(list);
      } else {
        return DataFailed(
           Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data));
    } catch (e) {
     return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<List<ProductNotAddedEntity>>> getProductProductListByDate(
      DateTime date, int categoryId) async {
    try {
      final httpResponse =
          await _staleProductService.getProductListByDate(date, categoryId);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ProductNotAddedEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ProductNotAddedModel.fromJson(item as Map<String, dynamic>))
          .toList();
        return DataSuccess(list);
      } else {
        return DataFailed(
            Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data));
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> updateStaleProduct(
      StaleProductToAddEntity staleProductToAdd) async {
    try {
      final httpResponse = await _staleProductService.updateStaleProduct(
          StaleProductToAddModel.fromEntity(staleProductToAdd));
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
             Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data));
    } catch (e) {
       return DataFailed(Failure(e.toString()));
    }
  }
}
