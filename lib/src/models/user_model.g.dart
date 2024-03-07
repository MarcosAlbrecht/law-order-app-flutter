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
      cpf: json['cpf'] as String?,
      active: json['active'] as bool?,
      birthday: json['birthday'] as String?,
      occupationArea: json['occupationArea'] as String?,
      isPasswordReset: json['isPasswordReset'] as bool?,
      type: json['type'] as int?,
      accessToken: json['accessToken'] as String?,
      profilePicture: json['profilePicture'] == null
          ? null
          : PictureModel.fromJson(
              json['profilePicture'] as Map<String, dynamic>),
      portfolioPictures: (json['portfolioPictures'] as List<dynamic>?)
          ?.map((e) => PictureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      portfolioAbout: json['portfolioAbout'] as String?,
      portfolioTitle: json['portfolioTitle'] as String?,
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rating: (json['rating'] as num?)?.toDouble(),
      pix: (json['pix'] as List<dynamic>?)
          ?.map((e) => PixModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tokenOneSignal: json['tokenOneSignal'] as String?,
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
      'cpf': instance.cpf,
      'active': instance.active,
      'birthday': instance.birthday,
      'occupationArea': instance.occupationArea,
      'isPasswordReset': instance.isPasswordReset,
      'type': instance.type,
      'accessToken': instance.accessToken,
      'profilePicture': instance.profilePicture,
      'portfolioPictures': instance.portfolioPictures,
      'portfolioAbout': instance.portfolioAbout,
      'portfolioTitle': instance.portfolioTitle,
      'skills': instance.skills,
      'services': instance.services,
      'rating': instance.rating,
      'pix': instance.pix,
      'tokenOneSignal': instance.tokenOneSignal,
    };
