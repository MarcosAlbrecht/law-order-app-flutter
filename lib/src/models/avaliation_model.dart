// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'avaliation_model.g.dart';

@JsonSerializable()
class AvaliationModel {
  @JsonKey(name: 'job_id')
  String? jobId;
  @JsonKey(name: 'level_of_satisfaction')
  int? levelOfSatisfaction;
  @JsonKey(name: 'service_quality')
  int? serviceQuality;
  @JsonKey(name: 'provider_punctuality')
  int? providerPunctuality;
  @JsonKey(name: 'platform_usability')
  int? platformUsability;
  @JsonKey(name: 'recommend_aplataform')
  int? recommendAPlataform;
  double? rating;
  AvaliationModel({
    this.levelOfSatisfaction,
    this.serviceQuality,
    this.providerPunctuality,
    this.platformUsability,
    this.recommendAPlataform,
    this.rating,
  });

  factory AvaliationModel.fromJson(Map<String, dynamic> json) => _$AvaliationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvaliationModelToJson(this);
}
