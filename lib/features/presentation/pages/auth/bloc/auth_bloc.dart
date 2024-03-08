

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/core/utils/user_login_params.dart';
import 'package:bakery_app/features/data/data_sources/local/shared_preference.dart';
import 'package:bakery_app/features/data/models/user.dart';
import 'package:bakery_app/features/domain/usecases/user_login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../screens/login_page.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;
  AuthBloc(this._authUseCase) : super(const AuthInitial()) {
    on<AuthLoginRequested>(onUserLogin);
  }

  void onUserLogin(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
        
    final dataState = await _authUseCase.userLogin(params: event.userLoginParams);
    

    if (dataState is DataSuccess && dataState.data != null) {
      emit(AuthSuccess(user: UserModel.fromEntity(dataState.data!)));
    }
    if (dataState is DataFailed) {
      emit(AuthFailure(error: dataState.error!));
    }
  }

  void onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    await UserPreferences.clearUser();
    var user = await UserPreferences.getUser();
    if (user == null) {
      emit(const AuthSuccess());
      Navigator.pushNamedAndRemoveUntil(
          event.context, LoginPage.routeName, (route) => false);
    } else {
      emit(const AuthFailure());
    }
  }
}
