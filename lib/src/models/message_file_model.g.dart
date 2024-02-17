// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageFileModel _$MessageFileModelFromJson(Map<String, dynamic> json) =>
    MessageFileModel(
      id: json['_id'] as String?,
      key: json['key'] as String?,
      temp: json['temp'] as bool?,
      url: json['url'] as String?,
      createdAt: json['createdAt'] as String?,
      fileLocalPath: json['fileLocalPath'] as String?,
    );

Map<String, dynamic> _$MessageFileModelToJson(MessageFileModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'key': instance.key,
      'temp': instance.temp,
      'url': instance.url,
      'createdAt': instance.createdAt,
      'fileLocalPath': instance.fileLocalPath,
    };
