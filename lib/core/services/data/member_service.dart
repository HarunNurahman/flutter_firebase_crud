import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_crud/modules/models/member/member_model.dart';

class MemberService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String usersCollection = 'users';
  final String memberSubCollection = 'members';

  // Create
  Future<void> createMember(String userId, MemberModel member) async {
    try {
      DocumentReference docRef = await firestore
          .collection(usersCollection)
          .doc(userId)
          .collection(memberSubCollection)
          .add(member.toJson());

      await docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception(e);
    }
  }

  // Read
  Future<MemberModel> getMember(String userId, String memberId) async {
    try {
      DocumentSnapshot doc =
          await firestore
              .collection(usersCollection)
              .doc(userId)
              .collection(memberSubCollection)
              .doc(memberId)
              .get();
      return MemberModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Read All
  Future<List<MemberModel>> getAllMembers(String userId) async {
    try {
      QuerySnapshot query =
          await firestore
              .collection(usersCollection)
              .doc(userId)
              .collection(memberSubCollection)
              .get();
      return query.docs
          .map(
            (doc) => MemberModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  // Delete
  Future<void> deleteMember(String userId, String memberId) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(userId)
          .collection(memberSubCollection)
          .doc(memberId)
          .delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  // Edit
  Future<void> updateMember(
    String userId,
    String memberId,
    MemberModel member,
  ) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(userId)
          .collection(memberSubCollection)
          .doc(memberId)
          .update(member.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
