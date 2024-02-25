// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'pix_model.g.dart';

@JsonSerializable()
class PixModel {
  bool? active;
  String? key;
  String? createdAt;

  PixModel({
    this.active,
    this.key,
    this.createdAt,
  });

  factory PixModel.fromJson(Map<String, dynamic> json) => _$PixModelFromJson(json);

  Map<String, dynamic> toJson() => _$PixModelToJson(this);
}
