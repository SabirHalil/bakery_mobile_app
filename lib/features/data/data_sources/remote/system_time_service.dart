import 'package:dio/dio.dart';
import '../../models/system_time.dart';

class SystemTimeService {
  Dio dio;
  SystemTimeService(this.dio);

  Future<Response> getSystemTime() async {
    return dio.get('/api/SystemAvailabilityTime/GetSystemAvailabilityTime');
  }

  Future<Response> updateSystemTime(SystemTimeModel systemTime) async {
    return dio.put('/api/SystemAvailabilityTime/UpdateSystemAvailabilityTime',
        data: systemTime.toJson());
  }
}
