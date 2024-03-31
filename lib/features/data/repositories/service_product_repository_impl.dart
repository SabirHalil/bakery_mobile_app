import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';

import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/service_product.dart';
import '../../domain/repositories/service_product_repository.dart';
import '../data_sources/remote/service_product_service.dart';
import '../models/service_product.dart';

class ServiceProductRepositoryImpl extends ServiceProductRepository {
  final ServiceProductService _serviceProductService;
  ServiceProductRepositoryImpl(this._serviceProductService);

  @override
  Future<DataState<void>> addServiceProduct(ServiceProductEntity serviceProduct) async{
  try {

      final httpResponse =await _serviceProductService.addServiceProduct(ServiceProductModel.fromEntity(serviceProduct));
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
             Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<List<ServiceProductEntity>>> getAllServiceProducts() async{
       try {
      final httpResponse = await _serviceProductService.getAllServiceProducts();
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ServiceProductEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ServiceProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
        return DataSuccess(list);
      } else {
        return DataFailed(
            Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> updateServiceProduct(ServiceProductEntity serviceProduct) async{
      try {

      final httpResponse = await _serviceProductService.updateServiceProduct(ServiceProductModel.fromEntity(serviceProduct));
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
             Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
    return DataFailed(Failure(e.toString()));
    }
  }
  
}
