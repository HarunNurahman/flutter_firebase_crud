import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_crud/modules/models/user/user_model.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> setUsers(UserModel user) async {
    try {
      users.doc(user.userId).set({
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> getUserbyId(String id) async {
    try {
      DocumentSnapshot documentSnapshot = await users.doc(id).get();
      return UserModel(
        userId: id,
        name: documentSnapshot['name'],
        email: documentSnapshot['email'],
        phone: documentSnapshot['phone'],
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
