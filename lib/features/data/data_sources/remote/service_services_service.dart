
import 'package:bakery_app/features/data/models/service_added_market.dart';
import 'package:bakery_app/features/data/models/service_list.dart';
import 'package:bakery_app/features/data/models/service_market.dart';
import 'package:bakery_app/features/data/models/service_market_to_add.dart';

import '../../../../core/constants/constants.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'service_services_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ServiceServicesApiService {
  factory ServiceServicesApiService(Dio dio, String baseUrl) = _ServiceServicesApiService;

  @GET("/api/Service/GetByDateServiceList")
  Future<HttpResponse<List<ServiceListModel>>> getServiceServicesByDate(
      @Query("date") DateTime date);

  @POST("/api/Service/AddServiceListAndListDetail")
  Future<HttpResponse> addServiceMarkets(
      @Query("userId") int userId,
      @Body() List<ServiceMarketToAddModel> marketList);

  @GET("/api/Service/GetAddedMarketByServiceListId")
  Future<HttpResponse<List<ServiceAddedMarketModel>>> getAddedMarketsByListId(
      @Query("listId") int listId);

  @GET("/api/Service/GetMarketByServiceListId")
  Future<HttpResponse<List<ServiceMarketModel>>> getAvailableMarketsByListId(
      @Query("listId") int listId);

  @DELETE("/api/Service/DeleteServiceListDetail")
  Future<HttpResponse> deleteMarketFromList(@Query("id") int id);

  @PUT("/api/Service/UpdateServiceListDetail")
  Future<HttpResponse> updateMarketFromList(@Body() ServiceMarketToAddModel doughListProduct);
}
