import 'package:dio/dio.dart';

import '../../models/market.dart';

class MarketService {
    Dio dio;
  MarketService(this.dio);

  Future<Response> getAllMarkets() async {
    return await dio.get('/api/Market/GetAllMarket');
  }

  Future<Response> addMarket(MarketModel market) async {
    return await dio.post('/api/Market/AddMarket', data: market.toJson());
  }

  Future<Response> updateMarket(MarketModel market) async {
    return await dio.put('/api/Market/UpdateMarket', data: market.toJson());
  }
}
