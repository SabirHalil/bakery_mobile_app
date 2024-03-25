import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/market_service.dart';
import 'package:bakery_app/features/data/models/market.dart';
import 'package:bakery_app/features/domain/entities/market.dart';
import 'package:bakery_app/features/domain/repositories/market_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';

class MarketRepositoryImpl extends MarketRepository {
  final MarketService _marketService;
  MarketRepositoryImpl(this._marketService);

  @override
  Future<DataState<void>> addMarket(MarketEntity market) async{
  try {

      final httpResponse =await _marketService.addMarket(MarketModel.fromEntity(market));
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

  @override
  Future<DataState<List<MarketEntity>>> getAllMarkets() async{
       try {
      final httpResponse = await _marketService.getAllMarkets();
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<MarketEntity>? list = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => MarketModel.fromJson(item as Map<String, dynamic>))
          .toList();
        return DataSuccess(list);
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

  @override
  Future<DataState<void>> updateMarket(MarketEntity market) async{
      try {

      final httpResponse = await _marketService.updateMarket(MarketModel.fromEntity(market));
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
