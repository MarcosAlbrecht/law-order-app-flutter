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
    );

Map<String, dynamic> _$PictureModelToJson(PictureModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'key': instance.key,
      'temp': instance.name,
      'url': instance.url,
    };
