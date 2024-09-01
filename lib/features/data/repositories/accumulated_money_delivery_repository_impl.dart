import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/accumulated_money_delivery.dart';
import '../../domain/repositories/accumulated_money_delivery_repository.dart';
import '../data_sources/remote/accumulated_money_delivery_service.dart';
import '../models/accumulated_money_delivery.dart';

class AccumulatedMoneyDeliveryRepositoryImpl
    extends AccumulatedMoneyDeliveryRepositroy {
  final AccumulatedMoneyDeliveryService _accumulatedMoneyDeliveryService;
  AccumulatedMoneyDeliveryRepositoryImpl(this._accumulatedMoneyDeliveryService);

  @override
  Future<DataState<void>> addAccumulatedMoneyDelivery(
      AccumulatedMoneyDeliveryEntity accumulatedMoneyDelivery) async {
    try {
      final httpResponse = await _accumulatedMoneyDeliveryService
          .addAccumulatedMoneyDelivery(AccumulatedMoneyDeliveryModel.fromEntity(
              accumulatedMoneyDelivery));
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
  Future<DataState<double?>> getAccumulatedCash() async {
    try {
      final httpResponse =
          await _accumulatedMoneyDeliveryService.getAccumulatedCash();
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data as double);
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
  Future<DataState<List<AccumulatedMoneyDeliveryEntity>?>>
      getAccumulatedMoneyDeliveryListByDateRange(
          DateTime startDate, DateTime endDate) async {
    try {
      final httpResponse = await _accumulatedMoneyDeliveryService
          .getAccumulatedMoneyDeliveryListByDateRange(startDate, endDate);
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<AccumulatedMoneyDeliveryModel>? list =
            (httpResponse.data as List<dynamic>)
                .map((dynamic item) => AccumulatedMoneyDeliveryModel.fromJson(
                    item as Map<String, dynamic>))
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
  Future<DataState<void>> updateAccumulatedMoneyDelivery(
      AccumulatedMoneyDeliveryEntity accumulatedMoneyDelivery) async {
    try {
      final httpResponse =
          await _accumulatedMoneyDeliveryService.updateAccumulatedMoneyDelivery(
              AccumulatedMoneyDeliveryModel.fromEntity(
                  accumulatedMoneyDelivery));
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
