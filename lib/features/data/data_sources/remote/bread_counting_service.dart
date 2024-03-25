import 'package:dio/dio.dart';

import '../../models/bread_counting.dart';

class BreadCountingService {
  Dio dio;
  BreadCountingService(this.dio);

  Future<Response> getBreadCountingByDate(DateTime date) async {
    return await dio.get("/api/BreadCounting/GetBreadCountingByDate",
        queryParameters: {"date": date});
  }

  Future<Response> addBreadCounting(BreadCountingModel breadCounting) async {
    return await dio.post(
      "/api/BreadCounting/AddBreadCounting",
      data: breadCounting.toJson(),
    );
  }

  Future<Response> deleteBreadCountingById(int id) async {
    return await dio.delete("/api/BreadCounting/DeleteBreadCountingById",
        queryParameters: {"id": id});
  }

  Future<Response> updateBreadCounting(BreadCountingModel breadCounting) async {
    return await dio.put('/api/BreadCounting/UpdateBreadCounting',
        data: breadCounting.toJson());
  }
}
