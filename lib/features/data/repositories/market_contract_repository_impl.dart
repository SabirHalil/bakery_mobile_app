import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';

import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../../core/utils/toast_message.dart';
import '../../domain/entities/market_contract.dart';
import '../../domain/repositories/market_contract_repository.dart';
import '../data_sources/remote/market_contract_service.dart';
import '../models/market_contract.dart';

class MarketContractRepositoryImpl extends MarketContractRepository {
  final MarketContractService _marketContractService;
  MarketContractRepositoryImpl(this._marketContractService);

  @override
  Future<DataState<void>> addMarketContract(MarketContractEntity marketContract) async{
  try {

      final httpResponse =await _marketContractService.addMarketContract(MarketContractModel.fromEntity(marketContract));
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
  Future<DataState<List<MarketContractEntity>>> getAllMarketContracts() async{
       try {
      final httpResponse = await _marketContractService.getAllMarketContracts();
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
  Future<DataState<void>> updateMarketContract(MarketContractEntity marketContract) async{
      try {

      final httpResponse = await _marketContractService.updateMarketContract(MarketContractModel.fromEntity(marketContract));
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
