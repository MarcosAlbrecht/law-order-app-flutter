// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'avaliation_model.g.dart';

@JsonSerializable()
class AvaliationModel {
  @JsonKey(name: 'jobId')
  String? jobId;
  @JsonKey(name: 'levelOfSatisfaction')
  int? levelOfSatisfaction;
  @JsonKey(name: 'serviceQuality')
  int? serviceQuality;
  @JsonKey(name: 'providerPunctuality')
  int? providerPunctuality;
  @JsonKey(name: 'platformUsability')
  int? platformUsability;
  @JsonKey(name: 'recommendAPlataform')
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
