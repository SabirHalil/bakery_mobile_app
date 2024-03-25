
import 'package:dio/dio.dart';

class AuthApiService {
    Dio dio;
  AuthApiService(this.dio);
  Future<Response> loginUser(String userName, String password) async {
    return await dio.post(
      "/api/Auth/login",
      queryParameters: {"userName": userName, "password": password},
    );
  }

  Future<Response> logoutUser() async {
    return await dio.post(
      "/api/Auth/login",
    );
  }
}
