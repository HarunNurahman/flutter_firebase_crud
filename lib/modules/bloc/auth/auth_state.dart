part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailed extends AuthState {
  final String errorMessage;

  const AuthFailed(this.errorMessage);
}

// Register
final class AuthRegisterLoadingState extends AuthState {}

final class AuthRegisterSuccessState extends AuthState {
  final UserModel user;

  const AuthRegisterSuccessState(this.user);
}

final class AuthRegisterErrorState extends AuthState {
  final String errorMessage;

  const AuthRegisterErrorState(this.errorMessage);
}

// Login
final class AuthLoginLoadingState extends AuthState {}

final class AuthLoginSuccessState extends AuthState {
  final UserModel user;

  const AuthLoginSuccessState(this.user);
}

final class AuthLoginErrorState extends AuthState {
  final String errorMessage;

  const AuthLoginErrorState(this.errorMessage);
}

// Check current user
final class AuthCheckCurrentUserLoadingState extends AuthState {}

final class AuthCheckCurrentUserSuccessState extends AuthState {
  final User user;

  const AuthCheckCurrentUserSuccessState(this.user);
}

final class AuthCheckCurrentUserErrorState extends AuthState {
  final String errorMessage;

  const AuthCheckCurrentUserErrorState(this.errorMessage);
}
