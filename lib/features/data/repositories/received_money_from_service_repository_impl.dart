import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/received_money_from_service_service.dart';
import 'package:bakery_app/features/domain/entities/received_money_from_service.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import '../../../core/utils/show_snake_bar.dart';
import '../../domain/repositories/received_money_from_service_repository.dart';
import '../models/received_money_from_service.dart';

class ReceivedMoneyFromServiceRepositoryImpl
    extends ReceivedMoneyFromServiceRepository {
  final ReceivedMoneyFromService _receivedMoneyFromService;
  ReceivedMoneyFromServiceRepositoryImpl(this._receivedMoneyFromService);
  @override
  Future<DataState<void>> addReceivedMoneyFromService(
      ReceivedMoneyFromServiceEntity receivedMoneyFromService)async {
   try {
      final httpResponse = await _receivedMoneyFromService.addReceivedMoneyFromService(ReceivedMoneyFromServiceModel.fromEntity(receivedMoneyFromService));
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
  Future<DataState<void>> deleteReceivedMoneyFromServiceById(int id)async {
    try {
      
      final httpResponse =
          await _receivedMoneyFromService.deleteReceivedMoneyFromServiceById(id);
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
  Future<DataState<ReceivedMoneyFromServiceEntity?>>
      getReceivedMoneyFromServiceByDateAndServiceType( DateTime date, int servisTypeId)async {
try {
      final httpResponse = await _receivedMoneyFromService.getReceivedMoneyFromServiceByDateAndServiceType(date, servisTypeId);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      if(httpResponse.response.statusCode == HttpStatus.noContent){
         return const DataSuccess(null);
      }
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              requestOptions: httpResponse.response.requestOptions),
        );
     
    } catch (e) {
          showSnakeBar(e.toString(), null, null);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> updateReceivedMoneyFromService(
      ReceivedMoneyFromServiceEntity receivedMoneyFromService)async {
 try {
      final httpResponse =
          await _receivedMoneyFromService.updateReceivedMoneyFromService(ReceivedMoneyFromServiceModel.fromEntity(receivedMoneyFromService));
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
