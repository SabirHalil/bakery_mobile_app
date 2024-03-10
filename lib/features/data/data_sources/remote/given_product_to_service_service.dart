import 'package:bakery_app/features/data/models/given_product_to_service.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
part 'given_product_to_service_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class GivenProductToService {
  factory GivenProductToService(Dio dio, String baseUrl) = _GivenProductToService;
  @GET("/api/GivenProductsToService/GetGivenProductsToServiceByDateAndServisTypeId")
  Future<HttpResponse<List<GivenProductToServiceModel>>>getGivenProductToServiceListByDateAndServiceType(@Query("date") DateTime date, @Query("servisTypeId") int servisTypeId);
  @POST("/api/GivenProductsToService/AddGivenProductsToService")
  Future<HttpResponse> addGivenProductToService(@Body() GivenProductToServiceModel givenProductToService);
  @DELETE("/api/GivenProductsToService/DeleteGivenProductsToService")
  Future<HttpResponse> deleteGivenProductToService(@Query("id") int id);
  @PUT("/api/GivenProductsToService/UpdateGivenProductsToService")
  Future<HttpResponse> updateGivenProductToService(@Body() GivenProductToServiceModel givenProductToService);
}