import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/models/service_stale_product.dart';

import 'package:bakery_app/features/domain/entities/service_stale_product.dart';
import 'package:dio/dio.dart';


import '../../../core/utils/show_snake_bar.dart';
import '../../domain/repositories/service_stale_product_repository.dart';
import '../data_sources/remote/service_stale_product_service.dart';

class ServiceStaleProductRepositoryImpl extends ServiceStaleProductRepository {
  final ServiceStaleProduct _serviceStaleProduct;
  ServiceStaleProductRepositoryImpl(this._serviceStaleProduct);
  @override
  Future<DataState<void>> addServiceStaleProduct(
      ServiceStaleProductEntity serviceStaleProduct) async{
try {
      final httpResponse =
          await _serviceStaleProduct.addServiceStaleProduct(
              serviceStaleProduct:
                  ServiceStaleProductModel.fromEntity(serviceStaleProduct));
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
  Future<DataState<void>> deleteServiceStaleProduct(int id) async{
   try {
      
      final httpResponse =
          await _serviceStaleProduct.deleteServiceStaleProduct(id: id);
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
  Future<DataState<List<ServiceStaleProductEntity>>>
      getServiceStaleProductListByDateAndServiceType(
          DateTime date, int serviceTypeId) async{
       try {
      final httpResponse = await _serviceStaleProduct
          .getServiceStaleProductListByDateAndServiceType(
              date: date, servisTypeId: serviceTypeId);
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
  Future<DataState<void>> updateServiceStaleProduct(
      ServiceStaleProductEntity serviceStaleProduct) async{
  try {
      final httpResponse =
          await _serviceStaleProduct.updateServiceStaleProduct(
              serviceStaleProduct:
                  ServiceStaleProductModel.fromEntity(serviceStaleProduct));
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
