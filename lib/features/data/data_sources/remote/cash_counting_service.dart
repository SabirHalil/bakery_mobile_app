import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/cash_counting.dart';

part 'cash_counting_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CashCountingService {
  factory CashCountingService(Dio dio,String baseUrl) = _CashCountingService;
  @GET("/api/CashCounting/GetCashCountingByDate")
  Future<HttpResponse<CashCountingModel?>> getCashCountingByDate(@Query("date") DateTime date);
  @POST("/api/CashCounting/AddCashCounting")
  Future<HttpResponse> addCashCounting(@Body() CashCountingModel cashCounting);
  @DELETE("/api/CashCounting/DeleteCashCountingById")
  Future<HttpResponse> deleteCashCountingById(@Query("id") int id);
  @PUT("/api/CashCounting/UpdateCashCounting")
  Future<HttpResponse> updateCashCounting(@Body() CashCountingModel cashCounting);
}
