import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_crud/core/services/user_service.dart';
import 'package:flutter_firebase_crud/modules/models/user/user_model.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        userId: userCredential.user!.uid,
        email: email,
        name: name,
      );

      await UserService().setUsers(user);

      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = await UserService().getUserbyId(
        userCredential.user!.uid,
      );
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
