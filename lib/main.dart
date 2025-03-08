import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_crud/core/configs/routes.dart';
import 'package:flutter_firebase_crud/core/services/user/user_storage.dart';
import 'package:flutter_firebase_crud/firebase_options.dart';
import 'package:flutter_firebase_crud/modules/bloc/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  bool isLoggedIn = false;
  try {
    isLoggedIn = await UserStorage.isUserLoggedIn();
  } catch (e) {
    debugPrint('Error checking user status: $e');
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.red,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthCheckCurrentUserEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: GlobalKey<NavigatorState>(),
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: isLoggedIn ? '/home' : '/',
      ),
    );
  }
}
