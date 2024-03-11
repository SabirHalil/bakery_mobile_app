import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/utils/toast_message.dart';
import '../../domain/entities/system_time.dart';
import '../../domain/repositories/system_time_repository.dart';
import '../data_sources/remote/system_time_service.dart';
import '../models/system_time.dart';

class SystemTimeRepositoryImpl extends SystemTimeRepository {
  final SystemTimeService _systemTimeService;
  SystemTimeRepositoryImpl(this._systemTimeService);

 
  @override
  Future<DataState<SystemTimeEntity?>> getSystemTime() async {
    try {
      final httpResponse = await _systemTimeService.getSystemTime();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      if (httpResponse.response.statusCode == HttpStatus.noContent) {
        return const DataSuccess(null);
      }
      return DataFailed(
        DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions),
      );
    } catch (e) {
            showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> updateSystemTime(SystemTimeEntity systemTime) async {
    try {
      final httpResponse = await _systemTimeService.updateSystemTime(SystemTimeModel.fromEntity(systemTime));
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
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }
}
