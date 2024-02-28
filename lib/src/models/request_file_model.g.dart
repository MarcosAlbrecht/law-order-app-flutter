// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestFileModel _$RequestFileModelFromJson(Map<String, dynamic> json) =>
    RequestFileModel(
      id: json['_id'] as String?,
      key: json['key'] as String?,
      temp: json['temp'] as bool?,
      url: json['url'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$RequestFileModelToJson(RequestFileModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'key': instance.key,
      'temp': instance.temp,
      'url': instance.url,
      'createdAt': instance.createdAt,
    };
