// ignore_for_file: depend_on_referenced_packages

import 'package:bakery_app/core/constants/constants.dart';
import 'package:bakery_app/features/data/models/dough_added_product.dart';

import 'package:bakery_app/features/data/models/dough_list.dart';
import 'package:bakery_app/features/data/models/dough_product_to_add.dart';
import 'package:bakery_app/features/data/models/product_not_added.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'dough_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class DoughApiService {
  factory DoughApiService(Dio dio, String baseUrl) = _DoughApiService;

  @GET("/api/DoughFactory/GetByDateDoughFactoryList")
  Future<HttpResponse<List<DoughListModel>>> getListsByDate(
      @Query("date") DateTime date);

  @POST("/api/DoughFactory/AddDoughFactoryListAndListDetail")
  Future<HttpResponse> addDoughProducts(
    @Query("userId") int userId,
    @Body() List<DoughProductToAddModel> doughListProduct,
    @Query("date") DateTime date,
  );

  @GET("/api/DoughFactory/GetAddedDoughFactoryListDetailByListId")
  Future<HttpResponse<List<DoughAddedProductModel>>> getAddedProductsByListId(
      @Query("doughFactoryListId") int doughFactoryListId);

  @GET("/api/DoughFactory/GetNotAddedDoughFactoryListDetailByListId")
  Future<HttpResponse<List<ProductNotAddedModel>>> getAvailableProductsByListId(
      @Query("doughFactoryListId") int listId);

  @DELETE("/api/DoughFactory/DeleteDoughFactoryListDetail")
  Future<HttpResponse> deleteProductFromList(@Query("id") int id);

  @PUT("/api/DoughFactory/UpdateDoughFactoryListDetail")
  Future<HttpResponse> updateProductFromList(
      @Body() DoughProductToAddModel doughListProduct);
}
