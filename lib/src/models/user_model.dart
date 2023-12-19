// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'active')
  bool? active;
  @JsonKey(name: 'isPasswordReset')
  bool? isPasswordReset;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'accessToken')
  String? accessToken;
  UserModel({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.active,
    this.isPasswordReset,
    this.type,
    this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, phone: $phone, active: $active, isPasswordReset: $isPasswordReset, type: $type, accessToken: $accessToken)';
  }
}
