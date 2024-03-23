import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/market.dart';
part 'market_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class MarketService {
  factory MarketService(Dio dio, String baseUrl) = _MarketService;

 @GET("/api/Market/GetAllMarket")
  Future<HttpResponse<List<MarketModel>>> getAllMarkets();

  @POST("/api/Market/AddMarket")
  Future<HttpResponse<void>> addMarket(@Body() MarketModel market);

  @PUT("/api/Market/UpdateMarket")
  Future<HttpResponse> updateMarket(
      @Body() MarketModel market);

}
