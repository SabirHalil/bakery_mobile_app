import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/service_stale_service.dart';
import 'package:bakery_app/features/data/models/service_received_stale.dart';
import 'package:bakery_app/features/data/models/service_stale.dart';
import 'package:bakery_app/features/domain/entities/service_received_stale.dart';
import 'package:bakery_app/features/domain/entities/service_stale.dart';
import 'package:bakery_app/features/domain/entities/service_to_receive_stale.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../domain/repositories/service_stale_repository.dart';
import '../models/service_to_receive_stale.dart';

class ServiceStaleRepositoryImpl extends ServiceStaleRepository {
  final ServiceStaleService _serviceStaleService;
  ServiceStaleRepositoryImpl(this._serviceStaleService);
  @override
  Future<DataState<void>> addServiceReceivedStale(
      ServiceToReceiveStaleEntity serviceToReceiveStale) async {
    try {
      final ServiceToReceiveStaleModel serviceAccountReceivedModel =
          ServiceToReceiveStaleModel.fromEntity(serviceToReceiveStale);

      final httpResponse = await _serviceStaleService.addServiceReceivedStale(
           serviceAccountReceivedModel);
      if (httpResponse.statusCode! >= 200 &&
          httpResponse.statusCode! <= 300) {
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
  Future<DataState<void>> deleteServiceReceivedStale(
      int id) async {
    try {
      final httpResponse =
          await _serviceStaleService.deleteServiceReceivedStale(
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
  Future<DataState<List<ServiceStaleEntity>>> getServiceNotReceivedStaleByDate(
      DateTime date) async {
    try {
      final httpResponse = await _serviceStaleService.getServiceNotReceivedStaleByDate( date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ServiceStaleEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ServiceStaleModel.fromJson(item as Map<String, dynamic>))
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
  Future<DataState<List<ServiceReceivedStaleEntity>>>
      getServiceReceivedStaleByDate(DateTime date) async {
    try {
      final httpResponse =
          await _serviceStaleService.getServiceReceivedStaleByDate(date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<ServiceReceivedStaleEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => ServiceReceivedStaleModel.fromJson(item as Map<String, dynamic>))
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
  Future<DataState<void>> updateServiceReceivedStale(
      ServiceToReceiveStaleEntity serviceToReceiveStale) async {
    try {
      final ServiceToReceiveStaleModel serviceAccountReceivedModel =
          ServiceToReceiveStaleModel.fromEntity(serviceToReceiveStale);
      final httpResponse =
          await _serviceStaleService.updateServiceReceivedStale(
              serviceAccountReceivedModel);
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
}
