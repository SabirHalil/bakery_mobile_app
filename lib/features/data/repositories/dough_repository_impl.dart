// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/dough_service.dart';
import 'package:bakery_app/features/data/models/dough_list.dart';
import 'package:bakery_app/features/data/models/dough_product_to_add.dart';
import 'package:bakery_app/features/data/models/product_not_added.dart';
import 'package:bakery_app/features/domain/entities/added_dough_list_product.dart';
import 'package:bakery_app/features/domain/entities/dough_product_to_add.dart';
import 'package:dio/dio.dart';
import 'package:bakery_app/features/domain/repositories/dough_repository.dart';

import '../../../core/error/failures.dart';
import '../../../core/utils/toast_message.dart';


class DoughRepositoryImpl extends DoughRepository {
  final DoughApiService _doughApiService;
  DoughRepositoryImpl(this._doughApiService);

  @override
  Future<DataState<void>> deleteDoughProductById(int id) async {
    try {
      final httpResponse = await _doughApiService.deleteProductFromList(id);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
             Failure(httpResponse.response.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<List<ProductNotAddedModel>>> getAvailableDoughProducts(
      int listId) async {
    try {
      final httpResponse =
          await _doughApiService.getAvailableProductsByListId(listId);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
             Failure(httpResponse.response.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<List<AddedDoughListProductEntity>>>
      getDoughListProductsByListId(int listId) async {
    try {
      final httpResponse = await _doughApiService.getAddedProductsByListId(
          listId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          Failure(httpResponse.response.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<List<DoughListModel>>> getDoughListsByDate(
      DateTime date) async {
    try {
      final httpResponse = await _doughApiService.getListsByDate( date);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
           Failure(httpResponse.response.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> updateDoughProduct(
      DoughProductToAddEntity doughProduct) async {
    try {
      final httpResponse = await _doughApiService.updateProductFromList(
          DoughProductToAddModel.fromEntity(doughProduct));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
             Failure(httpResponse.response.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<int>> addDoughProducts(int userId,
      List<DoughProductToAddEntity> doughListProduct, DateTime date) async {
    try {
      print(doughListProduct);
      final List<DoughProductToAddModel> doughListProductModels =
          doughListProduct
              .map((entity) => DoughProductToAddModel.fromEntity(entity))
              .toList();

      final httpResponse = await _doughApiService.addDoughProducts(
           userId,doughListProductModels, date);
      if (httpResponse.response.statusCode! >= 200 &&
          httpResponse.response.statusCode! <= 300) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
             Failure(httpResponse.response.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }
}
