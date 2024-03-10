import 'package:bakery_app/features/data/models/service_account_left.dart';
import 'package:bakery_app/features/data/models/service_account_received.dart';

import '../../../../core/constants/constants.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/service_account_to_receive.dart';

part 'service_account_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ServiceAccountService {
  factory ServiceAccountService(Dio dio, String baseUrl) = _ServiceAccountService;
  @GET("/api/MoneyReceivedFromMarket/GetMoneyReceivedMarketListByDate")
  Future<HttpResponse<List<ServiceAccountReceivedModel>>>
      getServiceAccountReceivedByDate(@Query("date") DateTime date);
  @GET("/api/MoneyReceivedFromMarket/GetNotMoneyReceivedMarketListByDate")
  Future<HttpResponse<List<ServiceAccountLeftModel>>>
      getServiceAccountLeftByDate(@Query("date") DateTime date);
  @POST("/api/MoneyReceivedFromMarket/AddMoneyReceivedFromMarket")
  Future<HttpResponse> addServiceAccountReceived(
      @Body() ServiceAccountToReceiveModel serviceAccountReceivedModel);
  @DELETE("/api/MoneyReceivedFromMarket/DeleteMoneyReceivedFromMarket")
  Future<HttpResponse> deleteServiceAccountReceived(
      @Body() ServiceAccountToReceiveModel serviceAccountReceivedModel);
  @PUT("/api/MoneyReceivedFromMarket/UpdateMoneyReceivedFromMarket")
  Future<HttpResponse> updateServiceAccountReceived(
      @Body() ServiceAccountToReceiveModel serviceAccountReceivedModel);
}
