import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/models/service_stale_product.dart';

import 'package:bakery_app/features/domain/entities/service_stale_product.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../domain/repositories/service_stale_product_repository.dart';
import '../data_sources/remote/service_stale_product_service.dart';

class ServiceStaleProductRepositoryImpl extends ServiceStaleProductRepository {
  final ServiceStaleProduct _serviceStaleProduct;
  ServiceStaleProductRepositoryImpl(this._serviceStaleProduct);
  @override
  Future<DataState<void>> addServiceStaleProduct(
      ServiceStaleProductEntity serviceStaleProduct) async {
    try {
      final httpResponse = await _serviceStaleProduct.addServiceStaleProduct(
          ServiceStaleProductModel.fromEntity(serviceStaleProduct));
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
  Future<DataState<void>> deleteServiceStaleProduct(int id) async {
    try {
      final httpResponse =
          await _serviceStaleProduct.deleteServiceStaleProduct(id);
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
  Future<DataState<List<ServiceStaleProductEntity>>>
      getServiceStaleProductListByDateAndServiceType(
          DateTime date, int serviceTypeId) async {
    try {
      final httpResponse = await _serviceStaleProduct
          .getServiceStaleProductListByDateAndServiceType(date, serviceTypeId);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ServiceStaleProductEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ServiceStaleProductModel.fromJson(item as Map<String, dynamic>))
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
  Future<DataState<void>> updateServiceStaleProduct(
      ServiceStaleProductEntity serviceStaleProduct) async {
    try {
      final httpResponse = await _serviceStaleProduct.updateServiceStaleProduct(
          ServiceStaleProductModel.fromEntity(serviceStaleProduct));
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
