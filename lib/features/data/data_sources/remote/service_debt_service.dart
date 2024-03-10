
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/service_debt_detail.dart';
import '../../models/service_debt_total.dart';
part 'service_debt_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ServiceDebtApiService {
  factory ServiceDebtApiService(Dio dio, String baseUrl) = _ServiceDebtApiService;

  @GET("/api/DebtMarket/GetDebtsOfMarkets")
  Future<HttpResponse<List<ServiceDebtTotalModel>>> getServiceDebtMarketsList();

   @GET("/api/DebtMarket/GetDebtByMarketId")
  Future<HttpResponse<List<ServiceDebtDetailModel>>> getServiceDebtDetailByMarketId(
      @Query("marketId") int marketId);

  @POST("/api/DebtMarket/PayDebt")
  Future<HttpResponse> postServicePayDebt(
      
      @Body() ServiceDebtDetailModel serviceDebtDetail);

  @DELETE("/api/DebtMarket/DeleteDebtMarket")
  Future<HttpResponse> deleteServiceDebtDetail(@Query("id") int id);

  @PUT("/api/DebtMarket/UpdateDebtMarket")
  Future<HttpResponse> updateServiceDebtDetail(@Body() ServiceDebtDetailModel serviceDebtDetail);
}
