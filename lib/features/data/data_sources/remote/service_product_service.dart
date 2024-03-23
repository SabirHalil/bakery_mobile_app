import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/service_product.dart';
part 'service_product_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ServiceProductService {
  factory ServiceProductService(Dio dio, String baseUrl) = _ServiceProductService;

 @GET("/api/ServiceProduct/GetAllServiceProduct")
  Future<HttpResponse<List<ServiceProductModel>>> getAllServiceProducts();

  @POST("/api/ServiceProduct/AddServiceProduct")
  Future<HttpResponse<void>> addServiceProduct(@Body() ServiceProductModel serviceProduct);

  @PUT("/api/ServiceProduct/UpdateServiceProduct")
  Future<HttpResponse> updateServiceProduct(
      @Body() ServiceProductModel serviceProduct);

}