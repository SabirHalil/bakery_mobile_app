import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/bread_counting.dart';
part 'bread_counting_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class BreadCountingService {
  factory BreadCountingService(Dio dio, String baseUrl) = _BreadCountingService;
  @GET("/api/BreadCounting/GetBreadCountingByDate")
  Future<HttpResponse<BreadCountingModel?>>
      getBreadCountingByDate(@Query("date") DateTime date);
  @POST("/api/BreadCounting/AddBreadCounting")
  Future<HttpResponse> addBreadCounting(
      @Body() BreadCountingModel breadCounting);
  @DELETE("/api/BreadCounting/DeleteBreadCountingById")
  Future<HttpResponse> deleteBreadCountingById(@Query("id") int id);
  @PUT("/api/BreadCounting/UpdateBreadCounting")
  Future<HttpResponse> updateBreadCounting(
      @Body() BreadCountingModel breadCounting);
}
