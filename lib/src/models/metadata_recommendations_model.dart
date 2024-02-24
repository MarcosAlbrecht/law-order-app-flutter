import 'package:app_law_order/src/models/metadata_model.dart';
import 'package:app_law_order/src/models/recommendation_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metadata_recommendations_model.g.dart';

@JsonSerializable()
class MetadataRecommendationsModel {
  MetadataModel? metadata;
  @JsonKey(name: 'result')
  List<RecommendationModel>? recommendations;

  MetadataRecommendationsModel({
    this.metadata,
    this.recommendations,
  });

  factory MetadataRecommendationsModel.fromJson(Map<String, dynamic> json) => _$MetadataRecommendationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataRecommendationsModelToJson(this);
}
