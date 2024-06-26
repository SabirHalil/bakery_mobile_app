import 'dart:io';
import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/service_account_service.dart';
import 'package:bakery_app/features/data/models/service_account_left.dart';
import 'package:bakery_app/features/data/models/service_account_received.dart';
import 'package:bakery_app/features/data/models/service_account_to_receive.dart';
import 'package:bakery_app/features/domain/entities/service_account_left.dart';
import 'package:bakery_app/features/domain/entities/service_account_received.dart';
import 'package:bakery_app/features/domain/entities/service_account_to_receive.dart';
import 'package:bakery_app/features/domain/repositories/service_account_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';


class ServiceAccountRepositoryImpl extends ServiceAccountRepository{
  final ServiceAccountService _serviceAccountService;
  ServiceAccountRepositoryImpl(this._serviceAccountService);
  @override
  Future<DataState<void>> addServiceAccountReceived(ServiceAccountToReceiveEntity serviceAccountReceived)async {
    try{
 final ServiceAccountToReceiveModel serviceAccountReceivedModel = ServiceAccountToReceiveModel.fromEntity(serviceAccountReceived);

      final httpResponse = await _serviceAccountService.addServiceAccountReceived(
          serviceAccountReceivedModel
          );
      if (httpResponse.statusCode! >= 200 && httpResponse.statusCode! <= 300  ) {
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
  Future<DataState<void>> deleteServiceAccountReceived(ServiceAccountToReceiveEntity serviceAccountReceived) async{
  try {
    ServiceAccountToReceiveModel serviceAccountReceivedModel = ServiceAccountToReceiveModel.fromEntity(serviceAccountReceived);
      final httpResponse = await _serviceAccountService.deleteServiceAccountReceived(serviceAccountReceivedModel);
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
  Future<DataState<List<ServiceAccountLeftEntity>>> getServiceAccountLeftByDate(DateTime date)async {
   try {
      final httpResponse = await _serviceAccountService.getServiceAccountLeftByDate( date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ServiceAccountLeftEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ServiceAccountLeftModel.fromJson(item as Map<String, dynamic>))
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
  Future<DataState<List<ServiceAccountReceivedEntity>>> getServiceAccountReceivedByDate(DateTime date)async {
   try {
      final httpResponse =
          await _serviceAccountService.getServiceAccountReceivedByDate(date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ServiceAccountReceivedEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ServiceAccountReceivedModel.fromJson(item as Map<String, dynamic>))
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
  Future<DataState<void>> updateServiceAccountReceived(ServiceAccountToReceiveEntity serviceAccountReceived)async {
  try {
    ServiceAccountToReceiveModel serviceAccountReceivedModel = ServiceAccountToReceiveModel.fromEntity(serviceAccountReceived);
      final httpResponse = await _serviceAccountService.updateServiceAccountReceived(serviceAccountReceivedModel);
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