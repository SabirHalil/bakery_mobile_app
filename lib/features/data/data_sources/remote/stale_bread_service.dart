import 'package:bakery_app/features/data/models/stale_bread_to_add.dart';
import 'package:dio/dio.dart';

class StaleBreadService {
  final Dio dio;
  StaleBreadService(this.dio);

  Future<Response> getAddedStaleBreadListByDate(DateTime date) async {
    return dio.get('/api/StaleBread/GetStaleBreadListByDate', queryParameters: {'date': date});
  }

  Future<Response> getBreadProductListByDate(DateTime date) async {
    return dio.get('/api/StaleBread/GetDoughFactoryProducts',
        queryParameters: {'date': date});
  }

  Future<Response> addStaleBread(StaleBreadToAddModel staleBreadToAdd) async {
    return dio.post('/api/StaleBread/AddStaleBread',
        data: staleBreadToAdd.toJson());
  }

  Future<Response> deleteStaleBread(int id) async {
    return dio.delete('/api/StaleBread/DeleteStaleBread',
        queryParameters: {'id': id});
  }

  Future<Response> updateStaleBread(
      StaleBreadToAddModel staleBreadToAdd) async {
    return dio.put('/api/StaleBread/UpdateStaleBread',
        data: staleBreadToAdd.toJson());
  }
}
