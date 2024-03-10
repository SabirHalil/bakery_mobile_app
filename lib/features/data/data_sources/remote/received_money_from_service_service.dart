import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/received_money_from_service.dart';
part 'received_money_from_service_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ReceivedMoneyFromService {
  factory ReceivedMoneyFromService(Dio dio,String baseUrl) = _ReceivedMoneyFromService;
  @GET("/api/ReceivedMoneyFromService/GetReceivedMoneyFromServiceByDateAndServiceType")
  Future<HttpResponse<ReceivedMoneyFromServiceModel?>>getReceivedMoneyFromServiceByDateAndServiceType(@Query("date") DateTime date, @Query("serviceType") int servisTypeId);
  @POST("/api/ReceivedMoneyFromService/AddReceivedMoneyFromService")
  Future<HttpResponse> addReceivedMoneyFromService(@Body() ReceivedMoneyFromServiceModel receivedMoneyFromService);
  @DELETE("/api/ReceivedMoneyFromService/DeleteReceivedMoneyFromServiceById")
  Future<HttpResponse> deleteReceivedMoneyFromServiceById(@Query("id") int id);
  @PUT("/api/ReceivedMoneyFromService/UpdateReceivedMoneyFromService")
  Future<HttpResponse> updateReceivedMoneyFromService(@Body() ReceivedMoneyFromServiceModel receivedMoneyFromService);
}