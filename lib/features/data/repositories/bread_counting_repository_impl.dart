import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/bread_counting_service.dart';
import 'package:bakery_app/features/data/models/bread_counting.dart';
import 'package:dio/dio.dart';

import 'package:bakery_app/features/domain/entities/bread_counting.dart';

import '../../../core/utils/show_snake_bar.dart';
import '../../domain/repositories/bread_counting_repository.dart';

class BreadCountingRepositoryImpl extends BreadCountingRepository {
  final BreadCountingService _breadCountingService;
  BreadCountingRepositoryImpl(this._breadCountingService);
  @override
  Future<DataState<void>> addBreadCounting(
      BreadCountingEntity breadCounting) async {
    try {
      final httpResponse = await _breadCountingService.addBreadCounting(
           BreadCountingModel.fromEntity(breadCounting));
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
  Future<DataState<void>> deleteBreadCountingById(int id) async {
    try {
      final httpResponse =
          await _breadCountingService.deleteBreadCountingById(id);
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
  Future<DataState<BreadCountingEntity?>> getBreadCountingByDate(
      DateTime date) async {
    try {
      final httpResponse =
          await _breadCountingService.getBreadCountingByDate(date);
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
      showSnakeBar(e.toString(), null, null);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> updateBreadCounting(
      BreadCountingEntity breadCounting) async {
    try {
      final httpResponse = await _breadCountingService.updateBreadCounting(
          BreadCountingModel.fromEntity(breadCounting));
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
