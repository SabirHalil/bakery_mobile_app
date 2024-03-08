part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();
  
  get user => null;
}

final class AuthInitial extends AuthState {
  const AuthInitial();
  
  @override
  List<Object?> get props => [];
}

final class AuthLoading extends AuthState {
  const AuthLoading();
  
  @override
  
  List<Object?> get props => [];
}

final class AuthSuccess extends AuthState {
  @override
  final UserModel? user;
  const AuthSuccess({this.user});
  
  @override
  
  List<Object?> get props => [user];
}

final class AuthFailure extends AuthState {
  final DioException? error;
  const AuthFailure({this.error});
  @override
  List<Object?> get props => [error];
}
