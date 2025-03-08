import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModel {
  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;

  MemberModel({this.id, this.name, this.phone, this.email, this.address});

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}
