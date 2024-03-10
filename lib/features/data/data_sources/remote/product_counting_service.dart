
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/product_counting_added.dart';
import '../../models/product_counting_to_add.dart';
import '../../models/product_not_added.dart';
part 'product_counting_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ProductCountingService {
  factory ProductCountingService(Dio dio, String baseUrl) = _ProductCountingService;

  @GET("/api/ProductsCounting/GetProductsCountingByDateAndCategory")
  Future<HttpResponse<List<ProductCountingAddedModel>>> getAddedProductsByDateAndCategoryId(
      @Query("date") DateTime date,
      @Query("categoryId") int categoryId
      );

  @GET("/api/ProductsCounting/GetNotAddedProductsCountingByDate")
  Future<HttpResponse<List<ProductNotAddedModel>>> getNotAddedProductsByCategoryId(
      @Query("date") DateTime date,
      @Query("categoryId") int categoryId);

  @POST("/api/ProductsCounting/AddProductsCounting")
  Future<HttpResponse> addProducts(
      
      @Body() ProductCountingToAddModel product,
      );


  @DELETE("/api/ProductsCounting/DeleteProductsCountingById")
  Future<HttpResponse> deleteProductById(@Query("id") int id);

  @PUT("/api/ProductsCounting/UpdateProductsCounting")
  Future<HttpResponse> updateProduct(
      @Body() ProductCountingToAddModel product);
}