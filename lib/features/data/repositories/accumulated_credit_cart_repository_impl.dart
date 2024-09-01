import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/domain/entities/accumulated_money.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../domain/repositories/accumulated_credit_cart_repository.dart';
import '../data_sources/remote/accumulated_credit_cart_service.dart';
import '../models/accumulated_money.dart';

class AccumulatedCreditCardRepositoryImpl extends AccumulatedCreditCardRepositroy {
  final AccumulatedCreditCardService _accumulatedCreditCardService;
  AccumulatedCreditCardRepositoryImpl(this._accumulatedCreditCardService);

  @override
  Future<DataState<void>> addAccumulatedCreditCard(
      AccumulatedMoneyEntity accumulatedCreditCard) async {
    try {
      final httpResponse = await _accumulatedCreditCardService.addAccumulatedCreditCard(
          AccumulatedMoneyModel.fromEntity(accumulatedCreditCard));
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
  Future<DataState<AccumulatedMoneyEntity?>> getAccumulatedCreditCardByDate(
      DateTime date) async {
    try {
      final httpResponse =
          await _accumulatedCreditCardService.getAccumulatedCreditCardByDate(date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        final accumulatedCreditCard =
            AccumulatedMoneyModel.fromJson(httpResponse.data);
        return DataSuccess(accumulatedCreditCard);
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
      getAccumulatedCreditCardListByDateRange(
          DateTime startDate, DateTime endDate) async {
    try {
      final httpResponse = await _accumulatedCreditCardService
          .getAccumulatedCreditCardListByDateRange(startDate, endDate);
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
  Future<DataState<void>> updateAccumulatedCreditCard(
      AccumulatedMoneyEntity accumulatedCreditCard) async {
     try {
      final httpResponse = await _accumulatedCreditCardService.updateAccumulatedCreditCard(
          AccumulatedMoneyModel.fromEntity(accumulatedCreditCard));
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
