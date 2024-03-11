import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/bread_price.dart';

part 'bread_price_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class BreadPriceService {
  factory BreadPriceService(Dio dio, String baseUrl) = _BreadPriceService;
  @GET("/api/BreadPrice/GetAllBreadPrices")
  Future<HttpResponse<List<BreadPriceModel>?>>getAllBreadPrices();
  @POST("/api/BreadPrice/AddBreadPrice")
  Future<HttpResponse> addBreadPrice(
      @Body() BreadPriceModel breadPrice);
  @PUT("/api/BreadPrice/UpdateBreadPrice")
  Future<HttpResponse> updateBreadPrice(
      @Body() BreadPriceModel breadPrice);
}