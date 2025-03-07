import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/modules/presentation/pages/auth/login_screen.dart';
import 'package:flutter_firebase_crud/modules/presentation/pages/auth/register_screen.dart';
import 'package:flutter_firebase_crud/modules/presentation/pages/home/form_data_screen.dart';
import 'package:flutter_firebase_crud/modules/presentation/pages/home/home_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => LoginScreen(),
      '/register': (context) => RegisterScreen(),
      '/home': (context) => HomeScreen(),
      '/form-data': (context) => FormDataScreen(),
    };
  }
}
