// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusInfoModel _$StatusInfoModelFromJson(Map<String, dynamic> json) =>
    StatusInfoModel(
      text: json['text'] as String?,
      opacidade: (json['opacidade'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StatusInfoModelToJson(StatusInfoModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'opacidade': instance.opacidade,
    };
