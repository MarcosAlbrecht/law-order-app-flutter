// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avaliation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvaliationModel _$AvaliationModelFromJson(Map<String, dynamic> json) =>
    AvaliationModel(
      levelOfSatisfaction: json['level_of_satisfaction'] as int?,
      serviceQuality: json['service_quality'] as int?,
      providerPunctuality: json['provider_punctuality'] as int?,
      platformUsability: json['platform_usability'] as int?,
      recommendAPlataform: json['recommend_aplataform'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
    )..jobId = json['job_id'] as String?;

Map<String, dynamic> _$AvaliationModelToJson(AvaliationModel instance) =>
    <String, dynamic>{
      'job_id': instance.jobId,
      'level_of_satisfaction': instance.levelOfSatisfaction,
      'service_quality': instance.serviceQuality,
      'provider_punctuality': instance.providerPunctuality,
      'platform_usability': instance.platformUsability,
      'recommend_aplataform': instance.recommendAPlataform,
      'rating': instance.rating,
    };
