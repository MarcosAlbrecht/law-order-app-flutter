import 'package:json_annotation/json_annotation.dart';

part 'metadata_model.g.dart';

@JsonSerializable()
class MetadataModel {
  MetadataModel({
    this.total,
    this.limit,
    this.skip,
  });

  int? total;
  int? limit;
  int? skip;

  factory MetadataModel.fromJson(Map<String, dynamic> json) => _$MetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataModelToJson(this);
}
