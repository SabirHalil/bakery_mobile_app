import 'package:bakery_app/features/data/models/product_process.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/dough_product_process.dart';
part 'products_process_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ProductsProcessService {
  factory ProductsProcessService(Dio dio, String baseUrl) = _ProductsProcessService;

  @GET("/api/Product/GetAllProductsBycategoryId")
  Future<HttpResponse<List<ProductProcessModel>>> getAllProductsByCategoryId(
      @Query("categoryId") int categoryId
      );

  @POST("/api/Product/AddProduct")
  Future<HttpResponse<void>> addProduct(@Body() ProductProcessModel product);

  @PUT("/api/Product/UpdateProduct")
  Future<HttpResponse> updateProduct(
      @Body() ProductProcessModel product);

 @GET("/api/DoughFactoryProduct/GetDoughFactoryProducts")
  Future<HttpResponse<List<DoughProductProcessModel>>> getAllDoughProducts();

  @POST("/api/DoughFactoryProduct/AddDoughFactoryProduct")
  Future<HttpResponse<void>> addDoughProduct(@Body() DoughProductProcessModel doughProduct);

  @PUT("/api/DoughFactoryProduct/UpdateDoughFactoryProduct")
  Future<HttpResponse<void>> updateDoughProduct(
      @Body() DoughProductProcessModel doughProduct);
}
