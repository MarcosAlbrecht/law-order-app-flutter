// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userType: json['userType'] as String?,
      phone: json['phone'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      cep: json['cep'] as String?,
      active: json['active'] as bool?,
      birthday: json['birthday'] as String?,
      occupationArea: json['occupationArea'] as String?,
      isPasswordReset: json['isPasswordReset'] as bool?,
      type: json['type'] as int?,
      accessToken: json['accessToken'] as String?,
      profilePicture: json['profilePicture'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userType': instance.userType,
      'phone': instance.phone,
      'city': instance.city,
      'state': instance.state,
      'cep': instance.cep,
      'active': instance.active,
      'birthday': instance.birthday,
      'occupationArea': instance.occupationArea,
      'isPasswordReset': instance.isPasswordReset,
      'type': instance.type,
      'accessToken': instance.accessToken,
      'profilePicture': instance.profilePicture,
    };
