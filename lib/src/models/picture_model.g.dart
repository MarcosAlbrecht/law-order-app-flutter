// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureModel _$PictureModelFromJson(Map<String, dynamic> json) => PictureModel(
      id: json['_id'] as String?,
      key: json['key'] as String?,
      name: json['temp'] as bool?,
      url: json['url'] as String?,
      localPath: json['localPath'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PictureModelToJson(PictureModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'key': instance.key,
      'temp': instance.name,
      'url': instance.url,
      'localPath': instance.localPath,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
