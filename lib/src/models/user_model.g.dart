// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['ID'] as String,
      email: json['EMAIL'] as String,
      name: json['NAME'] as String,
      firstName: json['FIRSTNAME'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'ID': instance.id,
      'EMAIL': instance.email,
      'NAME': instance.name,
      'FIRSTNAME': instance.firstName,
    };
