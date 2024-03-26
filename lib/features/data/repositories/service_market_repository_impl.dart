import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/service_services_service.dart';
import 'package:bakery_app/features/data/models/service_list.dart';
import 'package:bakery_app/features/data/models/service_market.dart';
import 'package:bakery_app/features/data/models/service_market_to_add.dart';
import 'package:bakery_app/features/domain/entities/service_added_market.dart';
import 'package:bakery_app/features/domain/entities/service_list.dart';
import 'package:bakery_app/features/domain/entities/service_market.dart';
import 'package:bakery_app/features/domain/entities/service_market_to_add.dart';
import 'package:bakery_app/features/domain/repositories/service_market_repository.dart';

import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../models/service_added_market.dart';


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
          userId,marketListModels,
          
          );
      if (httpResponse.statusCode! >= 200 && httpResponse.statusCode! <= 300  ) {
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
  Future<DataState<void>> deleteServiceMarketById(int id)async {
 try {
      final httpResponse = await _serviceServicesApiService.deleteMarketFromList(id);
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
  Future<DataState<List<ServiceMarketEntity>>> getAvailableServiceMarkets(
      int listId)async {
 try {
      final httpResponse =
          await _serviceServicesApiService.getAvailableMarketsByListId(listId);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ServiceMarketEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ServiceMarketModel.fromJson(item as Map<String, dynamic>))
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
  Future<DataState<List<ServiceAddedMarketEntity>>>
      getServiceListMarketsByListId(int listId)async {
  try {
      final httpResponse = await _serviceServicesApiService.getAddedMarketsByListId(
          listId);

      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ServiceAddedMarketEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ServiceAddedMarketModel.fromJson(item as Map<String, dynamic>))
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
  Future<DataState<List<ServiceListEntity>>> getServiceListsByDate(
      DateTime date)async {
 try {
      final httpResponse = await _serviceServicesApiService.getServiceServicesByDate( date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ServiceListEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ServiceListModel.fromJson(item as Map<String, dynamic>))
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
  Future<DataState<void>> updateServiceMarket(
      ServiceMarketToAddEntity serviceMarket)async {
   try {
      final httpResponse = await _serviceServicesApiService.updateMarketFromList(
          ServiceMarketToAddModel.fromEntity(serviceMarket));
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
