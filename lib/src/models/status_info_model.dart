// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status_info_model.g.dart';

@JsonSerializable()
class StatusInfoModel {
  final String? text;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color? color;
  double? opacidade;

  StatusInfoModel({
    this.text,
    this.color,
    this.opacidade,
  });

  factory StatusInfoModel.fromJson(Map<String, dynamic> json) => _$StatusInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusInfoModelToJson(this);
}
