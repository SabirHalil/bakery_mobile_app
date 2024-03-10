import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/service_stale_product.dart';
part 'service_stale_product_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ServiceStaleProduct {
  factory ServiceStaleProduct(Dio dio, String baseUrl) = _ServiceStaleProduct;
  @GET(
      "/api/ServiceStaleProduct/GetServiceStaleProductListByDateAndServiceTypeId")
  Future<HttpResponse<List<ServiceStaleProductModel>>>
      getServiceStaleProductListByDateAndServiceType(
          @Query("date") DateTime date,
          @Query("serviceTypeId") int servisTypeId);
  @POST("/api/ServiceStaleProduct/AddServiceStaleProduct")
  Future<HttpResponse> addServiceStaleProduct(
      @Body() ServiceStaleProductModel serviceStaleProduct);
  @DELETE("/api/ServiceStaleProduct/DeleteServiceStaleProduct")
  Future<HttpResponse> deleteServiceStaleProduct(@Query("id") int id);
  @PUT("/api/ServiceStaleProduct/UpdateServiceStaleProduct")
  Future<HttpResponse> updateServiceStaleProduct(
      @Body() ServiceStaleProductModel serviceStaleProduct);
}
