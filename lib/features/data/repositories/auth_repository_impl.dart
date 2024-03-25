
import 'dart:io';

import 'package:bakery_app/core/error/failures.dart';
import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/local/shared_preference.dart';
import 'package:bakery_app/core/utils/user_login_params.dart';
import 'package:bakery_app/features/data/data_sources/remote/auth_service.dart';
import 'package:bakery_app/features/data/models/user.dart';

import 'package:bakery_app/features/domain/entities/user.dart';
import 'package:bakery_app/features/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<UserEntity?>> userLogin(
      UserLoginParams? userLoginParams) async {
    try {
      final httpResponse = await _authApiService.loginUser(
          userLoginParams!.userName, userLoginParams.password);

      if (httpResponse.statusCode == HttpStatus.ok) {
        final user = UserModel.fromJson(httpResponse.data);
        UserPreferences.saveUser(user);
        return DataSuccess(user);
      } else {
        return DataFailed(Failure(httpResponse.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response?.data ?? "Beklenmedik bir hata oluştu"));
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<void> userLogout() {
    throw UnimplementedError();
  }
}
