import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/accumulated_cash_service.dart';
import 'package:bakery_app/features/domain/entities/accumulated_money.dart';
import 'package:bakery_app/features/domain/repositories/accumulated_cash_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../models/accumulated_money.dart';

class AccumulatedCashRepositoryImpl extends AccumulatedCashRepositroy {
  final AccumulatedCashService _accumulatedCashService;
  AccumulatedCashRepositoryImpl(this._accumulatedCashService);

  @override
  Future<DataState<void>> addAccumulatedCash(
      AccumulatedMoneyEntity accumulatedCash) async {
    try {
      final httpResponse = await _accumulatedCashService.addAccumulatedCash(
          AccumulatedMoneyModel.fromEntity(accumulatedCash));
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data ?? e.message));
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<AccumulatedMoneyEntity?>> getAccumulatedCashByDate(
      DateTime date) async {
    try {
      final httpResponse =
          await _accumulatedCashService.getAccumulatedCashByDate(date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        final accumulatedCash =
            AccumulatedMoneyModel.fromJson(httpResponse.data);
        return DataSuccess(accumulatedCash);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data ?? e.message));
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<List<AccumulatedMoneyEntity>?>>
      getAccumulatedCashListByDateRange(
          DateTime startDate, DateTime endDate) async {
    try {
      final httpResponse = await _accumulatedCashService
          .getAccumulatedCashListByDateRange(startDate, endDate);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<AccumulatedMoneyModel>? list = (httpResponse.data as List<dynamic>)
            .map((dynamic item) =>
                AccumulatedMoneyModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return DataSuccess(list);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data ?? e.message));
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> updateAccumulatedCash(
      AccumulatedMoneyEntity accumulatedCash) async {
     try {
      final httpResponse = await _accumulatedCashService.updateAccumulatedCash(
          AccumulatedMoneyModel.fromEntity(accumulatedCash));
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }
}
