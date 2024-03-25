import 'package:dio/dio.dart';
import '../../models/market_contract.dart';

class MarketContractService {
    Dio dio;
  MarketContractService(this.dio);

  Future<Response> getAllMarketContracts() async {
    return await dio.get('/api/MarketContract/GetAllMarketContract');
  }

  Future<Response> addMarketContract(MarketContractModel marketContract) async {
    return await dio.post('/api/MarketContract/AddMarketContract', data: marketContract.toJson());
  }

  Future<Response> updateMarketContract(MarketContractModel marketContract) async {
    return await dio.put('/api/MarketContract/UpdateMarketContract', data: marketContract.toJson());
  }
}
