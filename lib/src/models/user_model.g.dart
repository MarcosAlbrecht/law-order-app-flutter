// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      active: json['active'] as bool?,
      isPasswordReset: json['isPasswordReset'] as bool?,
      type: json['type'] as int?,
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'active': instance.active,
      'isPasswordReset': instance.isPasswordReset,
      'type': instance.type,
      'accessToken': instance.accessToken,
    };
