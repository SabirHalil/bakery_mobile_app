import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../../core/resources/data_state.dart';
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
      if (httpResponse.statusCode == HttpStatus.ok) {
        final item = SystemTimeModel.fromJson(httpResponse.data);
        return DataSuccess(item);
      }
      if (httpResponse.statusCode == HttpStatus.noContent) {
        return const DataSuccess(null);
      }
      return DataFailed(
          Failure(httpResponse.statusMessage!),
      );
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
     return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> updateSystemTime(SystemTimeEntity systemTime) async {
    try {
      final httpResponse = await _systemTimeService.updateSystemTime(SystemTimeModel.fromEntity(systemTime));
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
