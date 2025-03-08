part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

  const AuthRegisterEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({required this.email, required this.password});
}

class AuthCheckCurrentUserEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}
