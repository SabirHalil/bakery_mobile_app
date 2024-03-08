import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/service_stale_service.dart';
import 'package:bakery_app/features/domain/entities/service_received_stale.dart';
import 'package:bakery_app/features/domain/entities/service_stale.dart';
import 'package:bakery_app/features/domain/entities/service_to_receive_stale.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/show_snake_bar.dart';
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
          serviceToReceiveStaleModel: serviceAccountReceivedModel);
      if (httpResponse.response.statusCode! >= 200 &&
          httpResponse.response.statusCode! <= 300) {
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
  Future<DataState<void>> deleteServiceReceivedStale(
      int id) async {
    try {
      final httpResponse =
          await _serviceStaleService.deleteServiceReceivedStale(
              id: id);
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
  Future<DataState<List<ServiceStaleEntity>>> getServiceNotReceivedStaleByDate(
      DateTime date) async {
    try {
      final httpResponse = await _serviceStaleService.getServiceNotReceivedStaleByDate(date: date);
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
  Future<DataState<List<ServiceReceivedStaleEntity>>>
      getServiceReceivedStaleByDate(DateTime date) async {
    try {
      final httpResponse =
          await _serviceStaleService.getServiceReceivedStaleByDate(date: date);
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
  Future<DataState<void>> updateServiceReceivedStale(
      ServiceToReceiveStaleEntity serviceToReceiveStale) async {
    try {
      final ServiceToReceiveStaleModel serviceAccountReceivedModel =
          ServiceToReceiveStaleModel.fromEntity(serviceToReceiveStale);
      final httpResponse =
          await _serviceStaleService.updateServiceReceivedStale(
              serviceToReceiveStaleModel: serviceAccountReceivedModel);
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
