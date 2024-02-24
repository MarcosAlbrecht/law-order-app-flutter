import 'package:app_law_order/src/models/metadata_model.dart';
import 'package:app_law_order/src/models/recommendation_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metadata_recommendations_model.g.dart';

@JsonSerializable()
class MetadataRecommendationsModel {
  MetadataModel? metadata;
  List<RecommendationModel>? result;

  MetadataRecommendationsModel({
    this.metadata,
    this.result,
  });

  factory MetadataRecommendationsModel.fromJson(Map<String, dynamic> json) => _$MetadataRecommendationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataRecommendationsModelToJson(this);
}
