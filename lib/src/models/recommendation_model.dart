import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommendation_model.g.dart';

@JsonSerializable()
class RecommendationModel {
  @JsonKey(name: '_id')
  String? id;
  String? jobId;
  int? levelOfSatisfaction;
  int? serviceQuality;
  int? providerPunctuality;
  int? platformUsability;
  int? recommendAPlataform;
  double? rating;
  String? whoRecommendedId;
  String? recommendedId;
  String? createdAt;
  UserModel? whoRecommended;
  ServiceModel? serviceRequest;

  RecommendationModel({
    this.id,
    this.jobId,
    this.levelOfSatisfaction,
    this.serviceQuality,
    this.providerPunctuality,
    this.platformUsability,
    this.recommendAPlataform,
    this.rating,
    this.whoRecommendedId,
    this.recommendedId,
    this.createdAt,
    this.whoRecommended,
    this.serviceRequest,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) => _$RecommendationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationModelToJson(this);
}
