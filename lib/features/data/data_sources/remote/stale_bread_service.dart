import 'package:bakery_app/features/data/models/stale_bread.dart';
import 'package:bakery_app/features/data/models/stale_bread_added.dart';
import 'package:bakery_app/features/data/models/stale_bread_to_add.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';

part 'stale_bread_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class StaleBreadService {
  factory StaleBreadService(Dio dio, String baseUrl) = _StaleBreadService;
  @GET("/api/StaleBread/GetStaleBreadListByDate")
  Future<HttpResponse<List<StaleBreadAddedModel>>>
      getAddedStaleBreadListByDate(@Query("date") DateTime date);
  @GET("/api/StaleBread/GetDoughFactoryProducts")
  Future<HttpResponse<List<StaleBreadModel>>>
      getBreadProductListByDate(@Query("date") DateTime date);
  @POST("/api/StaleBread/AddStaleBread")
  Future<HttpResponse> addStaleBread(
      @Body() StaleBreadToAddModel staleBreadToAdd);
  @DELETE("/api/StaleBread/DeleteStaleBread")
  Future<HttpResponse> deleteStaleBread(
      @Query("id") int id);
  @PUT("/api/StaleBread/UpdateStaleBread")
  Future<HttpResponse> updateStaleBread(
      @Body() StaleBreadToAddModel staleBreadToAdd);
}
