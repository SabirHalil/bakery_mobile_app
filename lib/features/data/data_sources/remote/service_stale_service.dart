import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/service_received_stale.dart';
import '../../models/service_stale.dart';
import '../../models/service_to_receive_stale.dart';

part 'service_stale_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ServiceStaleService {
  factory ServiceStaleService(Dio dio, String baseUrl) = _ServiceStaleService;
  @GET("/api/StaleBreadReceivedFromMarket/GetStaleBreadReceivedFromMarketByDate")
  Future<HttpResponse<List<ServiceReceivedStaleModel>>>
      getServiceReceivedStaleByDate(@Query("date") DateTime date);
  @GET("/api/StaleBreadReceivedFromMarket/GetNoBreadReceivedMarketListByDate")
  Future<HttpResponse<List<ServiceStaleModel>>>
      getServiceNotReceivedStaleByDate(@Query("date") DateTime date);
  @POST("/api/StaleBreadReceivedFromMarket/AddStaleBreadReceivedFromMarket")
  Future<HttpResponse> addServiceReceivedStale(
      @Body() ServiceToReceiveStaleModel serviceToReceiveStaleModel);
  @DELETE("/api/StaleBreadReceivedFromMarket/DeleteStaleBreadReceivedFromMarketById")
  Future<HttpResponse> deleteServiceReceivedStale(
      @Query("id") int id);
  @PUT("/api/StaleBreadReceivedFromMarket/UpdateStaleBreadReceivedFromMarket")
  Future<HttpResponse> updateServiceReceivedStale(
      @Body() ServiceToReceiveStaleModel serviceToReceiveStaleModel);
}
