// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      isChecked: json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'value': instance.value,
      'isChecked': instance.isChecked,
    };
