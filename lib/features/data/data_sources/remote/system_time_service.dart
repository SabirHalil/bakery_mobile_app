import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../models/system_time.dart';

part 'system_time_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class SystemTimeService {
  factory SystemTimeService(Dio dio, String baseUrl) = _SystemTimeService;
  @GET("/api/SystemAvailabilityTime/GetSystemAvailabilityTime")
  Future<HttpResponse<SystemTimeModel?>>
      getSystemTime();
  @PUT("/api/SystemAvailabilityTime/UpdateSystemAvailabilityTime")
  Future<HttpResponse> updateSystemTime(
      @Body() SystemTimeModel systemTime);
}