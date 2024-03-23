import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';

import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../../core/utils/toast_message.dart';
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
  Future<DataState<List<ServiceProductEntity>>> getAllServiceProducts() async{
       try {
      final httpResponse = await _serviceProductService.getAllServiceProducts();
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
  Future<DataState<void>> updateServiceProduct(ServiceProductEntity serviceProduct) async{
      try {

      final httpResponse = await _serviceProductService.updateServiceProduct(ServiceProductModel.fromEntity(serviceProduct));
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
  
}
