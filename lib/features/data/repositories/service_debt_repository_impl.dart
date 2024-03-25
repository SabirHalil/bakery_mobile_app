import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/service_debt_service.dart';
import 'package:bakery_app/features/data/models/service_debt_detail.dart';
import 'package:bakery_app/features/data/models/service_debt_total.dart';
import 'package:bakery_app/features/domain/entities/service_debt_detail.dart';
import 'package:bakery_app/features/domain/entities/service_debt_total.dart';
import 'package:bakery_app/features/domain/repositories/service_debt_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';


class ServiceDebtRepositoryImpl extends ServiceDebtRepository {
  final ServiceDebtApiService _serviceDebtApiService;
  ServiceDebtRepositoryImpl(this._serviceDebtApiService);
  @override
  Future<DataState<void>> deleteServiceDebtDetail(int id) async {
    try {
      final httpResponse = await _serviceDebtApiService.deleteServiceDebtDetail(
          id);
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
             Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
 return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<List<ServiceDebtDetailEntity>>>
      getServiceDebtDetailByMarketId(int marketId)async {
 try {
      final httpResponse = await _serviceDebtApiService.getServiceDebtDetailByMarketId(marketId);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ServiceDebtDetailEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ServiceDebtDetailModel.fromJson(item as Map<String, dynamic>))
          .toList();
        return DataSuccess(list);
      } else {
        return DataFailed(
            Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<List<ServiceDebtTotalEntity>>> getServiceDebtMarketsList()async {
 try {
      final httpResponse = await _serviceDebtApiService.getServiceDebtMarketsList();
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ServiceDebtTotalEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ServiceDebtTotalModel.fromJson(item as Map<String, dynamic>))
          .toList();
        return DataSuccess(list);
      } else {
        return DataFailed(
            Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
       return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> postServicePayDebt(
      ServiceDebtDetailEntity serviceDebtDetail)async {
   try{
 final ServiceDebtDetailModel serviceDebtDetailModel = ServiceDebtDetailModel.fromEntity(serviceDebtDetail);

      final httpResponse = await _serviceDebtApiService.postServicePayDebt(
          serviceDebtDetailModel
          );
      if (httpResponse.statusCode! >= 200 && httpResponse.statusCode! <= 300  ) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
       return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> updateServiceDebtDetail(
      ServiceDebtDetailEntity serviceDebtDetail)async {
  try{
 final ServiceDebtDetailModel serviceDebtDetailModel = ServiceDebtDetailModel.fromEntity(serviceDebtDetail);

      final httpResponse = await _serviceDebtApiService.updateServiceDebtDetail(
          serviceDebtDetailModel
          );
      if (httpResponse.statusCode! >= 200 && httpResponse.statusCode! <= 300  ) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
           Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
       return DataFailed(Failure(e.toString()));
    }
  }
}
