// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationModel _$RecommendationModelFromJson(Map<String, dynamic> json) =>
    RecommendationModel(
      id: json['_id'] as String?,
      jobId: json['jobId'] as String?,
      levelOfSatisfaction: (json['levelOfSatisfaction'] as num?)?.toInt(),
      serviceQuality: (json['serviceQuality'] as num?)?.toInt(),
      providerPunctuality: (json['providerPunctuality'] as num?)?.toInt(),
      platformUsability: (json['platformUsability'] as num?)?.toInt(),
      recommendAPlataform: (json['recommendAPlataform'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      whoRecommendedId: json['whoRecommendedId'] as String?,
      recommendedId: json['recommendedId'] as String?,
      createdAt: json['createdAt'] as String?,
      whoRecommended: json['whoRecommended'] == null
          ? null
          : UserModel.fromJson(json['whoRecommended'] as Map<String, dynamic>),
      serviceRequest: json['serviceRequest'] == null
          ? null
          : ServiceModel.fromJson(
              json['serviceRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecommendationModelToJson(
        RecommendationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'jobId': instance.jobId,
      'levelOfSatisfaction': instance.levelOfSatisfaction,
      'serviceQuality': instance.serviceQuality,
      'providerPunctuality': instance.providerPunctuality,
      'platformUsability': instance.platformUsability,
      'recommendAPlataform': instance.recommendAPlataform,
      'rating': instance.rating,
      'whoRecommendedId': instance.whoRecommendedId,
      'recommendedId': instance.recommendedId,
      'createdAt': instance.createdAt,
      'whoRecommended': instance.whoRecommended,
      'serviceRequest': instance.serviceRequest,
    };
