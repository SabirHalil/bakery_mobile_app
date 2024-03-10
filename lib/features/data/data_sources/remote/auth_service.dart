import 'package:bakery_app/core/constants/constants.dart';

import 'package:bakery_app/features/data/models/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'auth_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio,String baseUrl) = _AuthApiService;
  @POST("/api/Auth/login")
  Future<HttpResponse<UserModel?>> loginUser(
    @Query("userName") String userName,
    @Query("password") String password
  );
  @POST("/api/Auth/logout")
  Future<HttpResponse> logoutUser();

  
}
