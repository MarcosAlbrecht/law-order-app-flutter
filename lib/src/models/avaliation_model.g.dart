// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avaliation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvaliationModel _$AvaliationModelFromJson(Map<String, dynamic> json) =>
    AvaliationModel(
      levelOfSatisfaction: json['levelOfSatisfaction'] as int?,
      serviceQuality: json['serviceQuality'] as int?,
      providerPunctuality: json['providerPunctuality'] as int?,
      platformUsability: json['platformUsability'] as int?,
      recommendAPlataform: json['recommendAPlataform'] as int?,
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
