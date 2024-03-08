import 'dart:io';

import 'package:dio/dio.dart';
import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/stale_bread_service.dart';
import 'package:bakery_app/features/data/models/stale_bread_to_add.dart';

import 'package:bakery_app/features/domain/entities/stale_bread.dart';

import 'package:bakery_app/features/domain/entities/stale_bread_added.dart';

import 'package:bakery_app/features/domain/entities/stale_bread_to_add.dart';

import '../../../core/utils/show_snake_bar.dart';
import '../../domain/repositories/stale_bread_repository.dart';

class StaleBreadRepositoryImpl extends StaleBreadRepository {
  final StaleBreadService _staleBreadService;
  StaleBreadRepositoryImpl(this._staleBreadService);

  @override
  Future<DataState<void>> addStaleBread(StaleBreadToAddEntity staleBreadToAdd)async {
    try {
      final httpResponse = await _staleBreadService.addStaleBread(
          staleBreadToAdd: StaleBreadToAddModel.fromEntity(staleBreadToAdd));
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
  Future<DataState<void>> deleteStaleBread(int id) async{
try {
      final httpResponse =
          await _staleBreadService.deleteStaleBread(
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
  Future<DataState<List<StaleBreadAddedEntity>>> getAddedStaleBreadListByDate(
      DateTime date) async{
       try {
      final httpResponse = await _staleBreadService.getAddedStaleBreadListByDate(date: date);
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
  Future<DataState<List<StaleBreadEntity>>> getBreadProductListByDate(
      DateTime date)async {
 try {
      final httpResponse =
          await _staleBreadService.getBreadProductListByDate(date: date);
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
  Future<DataState<void>> updateStaleBread(
      StaleBreadToAddEntity staleBreadToAdd)async {
try {
      final httpResponse =
          await _staleBreadService.updateStaleBread(
              staleBreadToAdd: StaleBreadToAddModel.fromEntity(staleBreadToAdd));
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
