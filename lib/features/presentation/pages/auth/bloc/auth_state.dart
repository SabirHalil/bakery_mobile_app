part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();

}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSuccess extends AuthState {
  final UserModel? user;
  const AuthSuccess({this.user});
  
}

final class AuthFailure extends AuthState {
  final String? error;
  const AuthFailure({this.error});
}
