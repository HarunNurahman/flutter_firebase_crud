import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/modules/presentation/pages/auth/login_screen.dart';
import 'package:flutter_firebase_crud/modules/presentation/pages/auth/register_screen.dart';
import 'package:flutter_firebase_crud/modules/presentation/pages/home/form_data_screen.dart';
import 'package:flutter_firebase_crud/modules/presentation/pages/home/home_screen.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        switch (settings.name) {
          case '/':
            return const LoginScreen();
          case '/register':
            return const RegisterScreen();
          case '/home':
            return const HomeScreen();
          case '/form-data':
            return const FormDataScreen();
          default:
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
        }
      },
    );
  }
}
