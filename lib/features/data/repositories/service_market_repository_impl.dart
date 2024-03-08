import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/service_services_service.dart';
import 'package:bakery_app/features/data/models/service_market_to_add.dart';
import 'package:bakery_app/features/domain/entities/service_added_market.dart';
import 'package:bakery_app/features/domain/entities/service_list.dart';
import 'package:bakery_app/features/domain/entities/service_market.dart';
import 'package:bakery_app/features/domain/entities/service_market_to_add.dart';
import 'package:bakery_app/features/domain/repositories/service_market_repository.dart';

import 'package:dio/dio.dart';

import '../../../core/utils/show_snake_bar.dart';

class ServiceMarketRepositoryImpl extends ServiceMarketRepository {
  final ServiceServicesApiService _serviceServicesApiService;
  ServiceMarketRepositoryImpl(this._serviceServicesApiService);

  @override
  Future<DataState<int>> addServiceMarkets(int userId, List<ServiceMarketToAddEntity> serviceListMarket)async {
       try {
      final List<ServiceMarketToAddModel> marketListModels =
          serviceListMarket
              .map((entity) => ServiceMarketToAddModel.fromEntity(entity))
              .toList();

      final httpResponse = await _serviceServicesApiService.addServiceMarkets(
          marketList: marketListModels,
          userId: userId
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
          showSnakeBar(e.toString(), null, null);
      rethrow;
    }
    
  }

  @override
  Future<DataState<void>> deleteServiceMarketById(int id)async {
 try {
      final httpResponse = await _serviceServicesApiService.deleteMarketFromList(id: id);
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
  Future<DataState<List<ServiceMarketEntity>>> getAvailableServiceMarkets(
      int listId)async {
 try {
      final httpResponse =
          await _serviceServicesApiService.getAvailableMarketsByListId(listId: listId);
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
  Future<DataState<List<ServiceAddedMarketEntity>>>
      getServiceListMarketsByListId(int listId)async {
  try {
      final httpResponse = await _serviceServicesApiService.getAddedMarketsByListId(
          listId: listId);

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
  Future<DataState<List<ServiceListEntity>>> getServiceListsByDate(
      DateTime date)async {
 try {
      final httpResponse = await _serviceServicesApiService.getServiceServicesByDate(date: date);
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
  Future<DataState<void>> updateServiceMarket(
      ServiceMarketToAddEntity serviceMarket)async {
   try {
      final httpResponse = await _serviceServicesApiService.updateMarketFromList(
          doughListProduct: ServiceMarketToAddModel.fromEntity(serviceMarket));
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
