import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/core/utils/toast_message.dart';
import 'package:bakery_app/features/domain/entities/bread_price.dart';
import 'package:bakery_app/features/domain/repositories/bread_price_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../data_sources/remote/bread_price_service.dart';
import '../models/bread_price.dart';

class BreadPriceRepositoryImpl extends BreadPriceRepository {
  final BreadPriceService _breadPriceService;
  BreadPriceRepositoryImpl(this._breadPriceService);

  @override
  Future<DataState<void>> addBreadPrice(BreadPriceEntity breadPrice) async {
    try {
      final httpResponse = await _breadPriceService
          .addBreadPrice(BreadPriceModel.fromEntity(breadPrice));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            Failure(httpResponse.response.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<List<BreadPriceEntity>?>> getAllBreadPrices() async {
    try {
      final httpResponse = await _breadPriceService.getAllBreadPrices();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      if (httpResponse.response.statusCode == HttpStatus.noContent) {
        return const DataSuccess(null);
      }
      return DataFailed(
          Failure(httpResponse.response.statusMessage!),
      );
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> updateBreadPrice(BreadPriceEntity breadPrice) async {
    try {
      final httpResponse = await _breadPriceService
          .updateBreadPrice(BreadPriceModel.fromEntity(breadPrice));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
           Failure(httpResponse.response.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }
}
