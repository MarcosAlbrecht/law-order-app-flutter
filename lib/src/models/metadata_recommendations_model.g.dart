// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_recommendations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetadataRecommendationsModel _$MetadataRecommendationsModelFromJson(
        Map<String, dynamic> json) =>
    MetadataRecommendationsModel(
      metadata: json['metadata'] == null
          ? null
          : MetadataModel.fromJson(json['metadata'] as Map<String, dynamic>),
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => RecommendationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetadataRecommendationsModelToJson(
        MetadataRecommendationsModel instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'result': instance.result,
    };
