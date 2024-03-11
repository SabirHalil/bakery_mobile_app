import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/given_product_to_service_service.dart';
import 'package:bakery_app/features/data/models/given_product_to_service.dart';
import 'package:bakery_app/features/domain/entities/given_product_to_service.dart';
import 'package:bakery_app/features/domain/repositories/given_product_to_service_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/toast_message.dart';


class GivenProductToServiceRepositoryImpl
    extends GivenProductToServiceRepository {
  final GivenProductToService _givenProductToService;
  GivenProductToServiceRepositoryImpl(this._givenProductToService);
  @override
  Future<DataState<void>> addGivenProductToService(
      GivenProductToServiceEntity givenProductToService) async {
    try {
      final httpResponse =
          await _givenProductToService.addGivenProductToService(
            
                  GivenProductToServiceModel.fromEntity(givenProductToService));
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
  Future<DataState<void>> deleteGivenProductToService(int id) async {
    try {
      
      final httpResponse =
          await _givenProductToService.deleteGivenProductToService( id);
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
  Future<DataState<List<GivenProductToServiceEntity>>>
      getGivenProductToServiceListByDateAndServiceType(
          DateTime date, int servisTypeId) async {
    try {
      final httpResponse = await _givenProductToService
          .getGivenProductToServiceListByDateAndServiceType(
               date, servisTypeId);
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
  Future<DataState<void>> updateGivenProductToService(
      GivenProductToServiceEntity givenProductToService) async {
    try {
      final httpResponse =
          await _givenProductToService.updateGivenProductToService(
              
                  GivenProductToServiceModel.fromEntity(givenProductToService));
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
