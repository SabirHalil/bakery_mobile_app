import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/domain/entities/market.dart';

import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/market_contract.dart';
import '../../domain/repositories/market_contract_repository.dart';
import '../data_sources/remote/market_contract_service.dart';
import '../models/market.dart';
import '../models/market_contract.dart';

class MarketContractRepositoryImpl extends MarketContractRepository {
  final MarketContractService _marketContractService;

  MarketContractRepositoryImpl(this._marketContractService);

  @override
  Future<DataState<void>> addMarketContract(MarketContractEntity marketContract) async {
    try {
      final httpResponse = await _marketContractService.addMarketContract(
        MarketContractModel.fromEntity(marketContract)
      );
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
  Future<DataState<List<MarketContractEntity>>> getAllMarketContracts() async {
    try {
      final httpResponse = await _marketContractService.getAllMarketContracts();
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<MarketContractEntity>? contracts = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => MarketContractModel.fromJson(item as Map<String, dynamic>))
          .toList();
        return DataSuccess(contracts);
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
  Future<DataState<void>> updateMarketContract(MarketContractEntity marketContract) async {
    try {
      final httpResponse = await _marketContractService.updateMarketContract(
        MarketContractModel.fromEntity(marketContract)
      );
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
  Future<DataState<List<MarketEntity>>> getMarketsNotHaveContracts()async {
    try {
      final httpResponse = await _marketContractService.getMarketsNotHaveContracts();
      if (httpResponse.statusCode == HttpStatus.ok) {
        List<MarketEntity>? markets = (httpResponse.data as List<dynamic>)
          .map((dynamic item) => MarketModel.fromJson(item as Map<String, dynamic>))
          .toList();
        return DataSuccess(markets);
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
