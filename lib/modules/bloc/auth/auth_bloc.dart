import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_crud/core/services/auth/auth_service.dart';
import 'package:flutter_firebase_crud/core/services/user/user_storage.dart';
import 'package:flutter_firebase_crud/modules/models/user/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({AuthService? auth})
    : authService = auth ?? AuthService(),
      super(AuthInitial()) {
    on<AuthCheckCurrentUserEvent>(_authCheckCurrentUserEvent);
    on<AuthRegisterEvent>(_authRegisterEvent);
    on<AuthLoginEvent>(_authLoginEvent);
    on<AuthLogoutEvent>(_authLogoutEvent);
  }

  _authCheckCurrentUserEvent(
    AuthCheckCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthCheckCurrentUserLoadingState());
    try {
      final savedUserId = await UserStorage.getUser();
      if (savedUserId != null) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          emit(AuthCheckCurrentUserSuccessState(user));
        } else {
          await UserStorage.removeUser();
          emit(AuthCheckCurrentUserErrorState('No user logged in'));
        }
      } else {
        emit(AuthCheckCurrentUserErrorState('No user logged in'));
      }
    } catch (e) {
      emit(AuthCheckCurrentUserErrorState(e.toString()));
    }
  }

  _authRegisterEvent(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthRegisterLoadingState());
    try {
      UserModel user = await authService.register(
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
      );

      emit(AuthRegisterSuccessState(user));
    } catch (e) {
      emit(AuthRegisterErrorState(e.toString()));
    }
  }

  _authLoginEvent(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoadingState());
    try {
      UserModel user = await authService.login(
        email: event.email,
        password: event.password,
      );

      await UserStorage.saveUser(user.userId!);
      emit(AuthLoginSuccessState(user));
    } catch (e) {
      emit(AuthLoginErrorState(e.toString()));
    }
  }

  _authLogoutEvent(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await authService.logout();
      await UserStorage.removeUser();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
