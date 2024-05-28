// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avaliation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvaliationModel _$AvaliationModelFromJson(Map<String, dynamic> json) =>
    AvaliationModel(
      levelOfSatisfaction: (json['levelOfSatisfaction'] as num?)?.toInt(),
      serviceQuality: (json['serviceQuality'] as num?)?.toInt(),
      providerPunctuality: (json['providerPunctuality'] as num?)?.toInt(),
      platformUsability: (json['platformUsability'] as num?)?.toInt(),
      recommendAPlataform: (json['recommendAPlataform'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
    )..jobId = json['jobId'] as String?;

Map<String, dynamic> _$AvaliationModelToJson(AvaliationModel instance) =>
    <String, dynamic>{
      'jobId': instance.jobId,
      'levelOfSatisfaction': instance.levelOfSatisfaction,
      'serviceQuality': instance.serviceQuality,
      'providerPunctuality': instance.providerPunctuality,
      'platformUsability': instance.platformUsability,
      'recommendAPlataform': instance.recommendAPlataform,
      'rating': instance.rating,
    };
