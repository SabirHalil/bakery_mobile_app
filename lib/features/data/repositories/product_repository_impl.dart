// ignore_for_file: void_checks, depend_on_referenced_packages

import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/product_service.dart';
import 'package:bakery_app/features/data/models/product.dart';
import 'package:bakery_app/features/data/models/product_added.dart';
import 'package:bakery_app/features/data/models/product_to_add.dart';
import 'package:bakery_app/features/domain/entities/added_product.dart';
import 'package:bakery_app/features/domain/entities/product.dart';
import 'package:bakery_app/features/domain/entities/product_to_add.dart';
import 'package:bakery_app/features/domain/repositories/product_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';


class ProductRepositoryImpl extends ProductRepository {
  final ProductApiService _apiService;
  ProductRepositoryImpl(this._apiService);
  @override
  Future<DataState<String>> addProducts(int userId, int categoryId, List<ProductToAddEntity> productList,DateTime date) async {
    try {
      final List<ProductToAddModel> productModel =
          productList.map((e) => ProductToAddModel.fromEntity(e)).toList();
      final httpResponse = await _apiService.addProducts(userId,categoryId,productModel,date);
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
  Future<DataState<void>> deleteProductById(int id)async {
     try {
      final httpResponse = await _apiService.deleteProductById(id);
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
  Future<DataState<List<AddedProductEntity>>>
      getAddedProductsByDateAndCategoryId(DateTime date, int categoryId)async {
   try {
      final httpResponse = await _apiService.getAddedProductsByDateAndCategoryId(date,categoryId);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<AddedProductEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => AddedProductModel.fromJson(item as Map<String, dynamic>))
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
  Future<DataState<List<ProductEntity>>> getAvailableProductsByCategoryId(
      DateTime date, int categoryId)async {
  try {
      final httpResponse = await _apiService.getAvailableProductsByCategoryId(date, categoryId);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ProductEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ProductModel.fromJson(item as Map<String, dynamic>))
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
  Future<DataState<void>> updateProduct(ProductToAddEntity product)async {
  try {
      final httpResponse = await _apiService.updateProduct(ProductToAddModel.fromEntity(product));
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
