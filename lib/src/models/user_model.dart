// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'ID')
  String id;
  @JsonKey(name: 'EMAIL')
  String email;
  @JsonKey(name: 'NAME')
  String name;
  @JsonKey(name: 'FIRSTNAME')
  String firstName;
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.firstName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
