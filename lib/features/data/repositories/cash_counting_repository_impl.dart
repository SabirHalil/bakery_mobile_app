import 'dart:io';
import 'package:dio/dio.dart';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/cash_counting_service.dart';

import 'package:bakery_app/features/domain/entities/cash_counting.dart';

import '../../../core/error/failures.dart';
import '../../domain/repositories/cash_counting_repository.dart';
import '../models/cash_counting.dart';

class CashCountingRepositoryImpl extends CashCountingRepository {
  final CashCountingService _cashCountingService;
  CashCountingRepositoryImpl(this._cashCountingService);
  @override
  Future<DataState<void>> addCashCounting(
      CashCountingEntity cashCounting) async {
    try {
      final httpResponse = await _cashCountingService
          .addCashCounting(CashCountingModel.fromEntity(cashCounting));
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> deleteCashCountingById(int id) async {
    try {
      final httpResponse =
          await _cashCountingService.deleteCashCountingById(id);
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<CashCountingEntity?>> getCashCountingByDate(
      DateTime date) async {
    try {
      final httpResponse =
          await _cashCountingService.getCashCountingByDate(date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        final data = CashCountingModel.fromJson(httpResponse.data);
        return DataSuccess(data);
      }
      if (httpResponse.statusCode == HttpStatus.noContent) {
        return const DataSuccess(null);
      }
      return DataFailed(
        Failure(httpResponse.statusMessage!),
      );
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> updateCashCounting(
      CashCountingEntity cashCounting) async {
    try {
      final httpResponse = await _cashCountingService
          .updateCashCounting(CashCountingModel.fromEntity(cashCounting));
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }
}
