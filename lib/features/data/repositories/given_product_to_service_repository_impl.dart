import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/given_product_to_service_service.dart';
import 'package:bakery_app/features/data/models/given_product_to_service.dart';
import 'package:bakery_app/features/domain/entities/given_product_to_service.dart';
import 'package:bakery_app/features/domain/repositories/given_product_to_service_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';


class GivenProductToServiceRepositoryImpl extends GivenProductToServiceRepository {
  final GivenProductToService _givenProductToService;

  GivenProductToServiceRepositoryImpl(this._givenProductToService);

  @override
  Future<DataState<void>> addGivenProductToService(
      GivenProductToServiceEntity givenProductToService) async {
    try {
      final httpResponse = await _givenProductToService.addGivenProductToService(
        GivenProductToServiceModel.fromEntity(givenProductToService)
      );
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data));
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> deleteGivenProductToService(int id) async {
    try {
      final httpResponse = await _givenProductToService.deleteGivenProductToService(id);
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data));
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<List<GivenProductToServiceModel>>> getGivenProductToServiceListByDateAndServiceType(
      DateTime date, int servisTypeId) async {
    try {
      final httpResponse = await _givenProductToService.getGivenProductToServiceListByDateAndServiceType(
        date, servisTypeId
      );
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<GivenProductToServiceModel>? list = (httpResponse.data as List<dynamic>)
            .map((dynamic item) =>
        GivenProductToServiceModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return DataSuccess(list);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data));
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> updateGivenProductToService(
      GivenProductToServiceEntity givenProductToService) async {
    try {
      final httpResponse = await _givenProductToService.updateGivenProductToService(
        GivenProductToServiceModel.fromEntity(givenProductToService)
      );
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data));
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }
}
