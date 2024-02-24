// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetadataModel _$MetadataModelFromJson(Map<String, dynamic> json) =>
    MetadataModel(
      total: json['total'] as int?,
      limit: json['limit'] as int?,
      skip: json['skip'] as int?,
    );

Map<String, dynamic> _$MetadataModelToJson(MetadataModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'limit': instance.limit,
      'skip': instance.skip,
    };
