

import 'package:bakery_app/features/data/models/product_added.dart';
import 'package:bakery_app/features/data/models/product.dart';
import 'package:bakery_app/features/data/models/product_to_add.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
part 'product_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ProductApiService {
  factory ProductApiService(Dio dio, String baseUrl) = _ProductApiService;

  @GET("/api/ProductionList/GetAddedProductsByDateAndCategoryId")
  Future<HttpResponse<List<AddedProductModel>>> getAddedProductsByDateAndCategoryId(
      @Query("date") DateTime date,
      @Query("categoryId") int categoryId
      );

  @GET("/api/ProductionList/GetNotAddedProductsByListAndCategoryId")
  Future<HttpResponse<List<ProductModel>>> getAvailableProductsByCategoryId(
      @Query("date") DateTime date,
      @Query("categoryId") int categoryId);

  @POST("/api/ProductionList/AddProductionListAndDetail")
  Future<HttpResponse> addProducts(
      @Query("userId") int userId,
      @Query("categoryId") int categoryId,
      @Body() List<ProductToAddModel> doughListProduct,
      @Query("date") DateTime date);


  @DELETE("/api/ProductionList/DeleteProductionListDetail")
  Future<HttpResponse> deleteProductById(@Query("id") int id);

  @PUT("/api/ProductionList/UpdateProductionListDetail")
  Future<HttpResponse> updateProduct(
      @Body() ProductToAddModel product);
}
