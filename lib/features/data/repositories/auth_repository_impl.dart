// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bakery_app/core/error/failures.dart';
import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/local/shared_preference.dart';
import 'package:bakery_app/core/utils/user_login_params.dart';
import 'package:bakery_app/features/data/data_sources/remote/auth_service.dart';

import 'package:bakery_app/features/domain/entities/user.dart';
import 'package:bakery_app/features/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/toast_message.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<UserEntity?>> userLogin(
      UserLoginParams? userLoginParams) async {
    try {
      final httpResponse = await _authApiService.loginUser(
          userLoginParams!.userName, userLoginParams.password);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        UserPreferences.saveUser(httpResponse.data!);
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
            Failure(httpResponse.response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return DataFailed(Failure(e.response!.data));
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<void> userLogout() {
    throw UnimplementedError();
  }
}
