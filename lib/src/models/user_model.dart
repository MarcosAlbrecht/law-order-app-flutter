// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:app_law_order/src/models/picture_model.dart';
import 'package:app_law_order/src/models/service_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'password')
  String? password;
  @JsonKey(name: 'firstName')
  String? firstName;
  @JsonKey(name: 'lastName')
  String? lastName;
  @JsonKey(name: 'userType')
  String? userType;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'state')
  String? state;
  @JsonKey(name: 'cep')
  String? cep;
  @JsonKey(name: 'cpf')
  String? cpf;
  @JsonKey(name: 'active')
  bool? active;
  @JsonKey(name: 'birthday')
  String? birthday;
  @JsonKey(name: 'occupationArea')
  String? occupationArea;
  @JsonKey(name: 'isPasswordReset')
  bool? isPasswordReset;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'accessToken')
  String? accessToken;
  @JsonKey(name: 'profilePicture')
  PictureModel? profilePicture;
  @JsonKey(name: 'portfolioPictures')
  List<PictureModel>? portfolioPictures;
  @JsonKey(name: 'portfolioAbout')
  String? portfolioAbout;
  @JsonKey(name: 'portfolioTitle')
  String? portfolioTitle;
  @JsonKey(name: 'skills')
  List<String>? skills;
  @JsonKey(name: 'services')
  List<ServiceModel>? services;
  UserModel({
    this.id,
    this.email,
    this.name,
    this.password,
    this.firstName,
    this.lastName,
    this.userType,
    this.phone,
    this.city,
    this.state,
    this.cep,
    this.cpf,
    this.active,
    this.birthday,
    this.occupationArea,
    this.isPasswordReset,
    this.type,
    this.accessToken,
    this.profilePicture,
    this.portfolioPictures,
    this.portfolioAbout,
    this.portfolioTitle,
    this.skills,
    this.services,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, password: $password, firstName: $firstName, lastName: $lastName, userType: $userType, phone: $phone, city: $city, state: $state, cep: $cep, cpf: $cpf, active: $active, birthday: $birthday, occupationArea: $occupationArea, isPasswordReset: $isPasswordReset, type: $type, accessToken: $accessToken, profilePicture: $profilePicture, portfolioPictures: $portfolioPictures, portfolioAbout: $portfolioAbout, portfolioTitle: $portfolioTitle, skills: $skills, services: $services)';
  }
}
