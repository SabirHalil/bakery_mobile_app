import 'dart:io';
import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/service_account_service.dart';
import 'package:bakery_app/features/data/models/service_account_to_receive.dart';
import 'package:bakery_app/features/domain/entities/service_account_left.dart';
import 'package:bakery_app/features/domain/entities/service_account_received.dart';
import 'package:bakery_app/features/domain/entities/service_account_to_receive.dart';
import 'package:bakery_app/features/domain/repositories/service_account_repository.dart';
import 'package:dio/dio.dart';

class ServiceAccountRepositoryImpl extends ServiceAccountRepository{
  final ServiceAccountService _serviceAccountService;
  ServiceAccountRepositoryImpl(this._serviceAccountService);
  @override
  Future<DataState<void>> addServiceAccountReceived(ServiceAccountToReceiveEntity serviceAccountReceived)async {
    try{
 final ServiceAccountToReceiveModel serviceAccountReceivedModel = ServiceAccountToReceiveModel.fromEntity(serviceAccountReceived);

      final httpResponse = await _serviceAccountService.addServiceAccountReceived(
          serviceAccountReceivedModel: serviceAccountReceivedModel
          );
      if (httpResponse.response.statusCode! >= 200 && httpResponse.response.statusCode! <= 300  ) {
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
  Future<DataState<void>> deleteServiceAccountReceived(ServiceAccountToReceiveEntity serviceAccountReceived) async{
  try {
    ServiceAccountToReceiveModel serviceAccountReceivedModel = ServiceAccountToReceiveModel.fromEntity(serviceAccountReceived);
      final httpResponse = await _serviceAccountService.deleteServiceAccountReceived(serviceAccountReceivedModel: serviceAccountReceivedModel);
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
  Future<DataState<List<ServiceAccountLeftEntity>>> getServiceAccountLeftByDate(DateTime date)async {
   try {
      final httpResponse = await _serviceAccountService.getServiceAccountLeftByDate(date: date);
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
  Future<DataState<List<ServiceAccountReceivedEntity>>> getServiceAccountReceivedByDate(DateTime date)async {
   try {
      final httpResponse =
          await _serviceAccountService.getServiceAccountReceivedByDate(date: date);
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
  Future<DataState<void>> updateServiceAccountReceived(ServiceAccountToReceiveEntity serviceAccountReceived)async {
  try {
    ServiceAccountToReceiveModel serviceAccountReceivedModel = ServiceAccountToReceiveModel.fromEntity(serviceAccountReceived);
      final httpResponse = await _serviceAccountService.updateServiceAccountReceived(serviceAccountReceivedModel: serviceAccountReceivedModel);
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
  
}