import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/market_contract.dart';
part 'market_contract_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class MarketContractService {
  factory MarketContractService(Dio dio, String baseUrl) = _MarketContractService;

 @GET("/api/MarketContract/GetAllMarketContract")
  Future<HttpResponse<List<MarketContractModel>>> getAllMarketContracts();

  @POST("/api/MarketContract/AddMarketContract")
  Future<HttpResponse<void>> addMarketContract(@Body() MarketContractModel marketContract);

  @PUT("/api/MarketContract/UpdateMarketContract")
  Future<HttpResponse> updateMarketContract(
      @Body() MarketContractModel marketContract);

}