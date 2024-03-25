import 'package:dio/dio.dart';

import '../../models/bread_price.dart';


 class BreadPriceService {
    Dio dio;
  BreadPriceService(this.dio);

  Future<Response> getAllBreadPrices() async {
    return await dio.get('/api/BreadPrice/GetAllBreadPrices');
  }

  Future<Response> addBreadPrice(BreadPriceModel breadPrice) async {
    return await dio.post('/api/BreadPrice/AddBreadPrice',
        data: breadPrice.toJson());
  }


  Future<Response> updateBreadPrice(
     BreadPriceModel breadPrice) async {
    return await dio.put('/api/BreadPrice/UpdateBreadPrice',
        data: breadPrice.toJson());
  }
}
