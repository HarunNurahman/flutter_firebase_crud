// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  userId: json['id'] as String?,
  email: json['email'] as String?,
  name: json['name'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.userId,
  'email': instance.email,
  'name': instance.name,
  'phone': instance.phone,
};
