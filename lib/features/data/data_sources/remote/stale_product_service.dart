import 'package:bakery_app/features/data/models/stale_product_added.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/product_not_added.dart';
import '../../models/stale_product_to_add.dart';

part 'stale_product_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class StaleProductService {
  factory StaleProductService(Dio dio, String baseUrl) = _StaleProductService;
  @GET("/api/StaleProduct/GetByDateAndCategory")
  Future<HttpResponse<List<StaleProductAddedModel>>>
      getAddedStaleProductListByDate(
          @Query("date") DateTime date, @Query("categoryId") int categoryId);
  @GET("/api/StaleProduct/GetProductsNotAddedToStale")
  Future<HttpResponse<List<ProductNotAddedModel>>> getProductListByDate(
      @Query("date") DateTime date, @Query("categoryId") int categoryId);
  @POST("/api/StaleProduct/AddStaleProduct")
  Future<HttpResponse> addStaleProduct(
      @Body() StaleProductToAddModel staleProductToAdd);
  @DELETE("/api/StaleProduct/DeleteStaleProduct")
  Future<HttpResponse> deleteStaleProduct(@Query("id") int id);
  @PUT("/api/StaleProduct/UpdateStaleProduct")
  Future<HttpResponse> updateStaleProduct(
      @Body() StaleProductToAddModel staleProductToAdd);
}
