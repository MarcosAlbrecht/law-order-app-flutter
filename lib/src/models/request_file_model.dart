// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'request_file_model.g.dart';

@JsonSerializable()
class RequestFileModel {
  @JsonKey(name: '_id')
  String? id;
  String? key;
  bool? temp;
  String? url;
  String? createdAt;
  RequestFileModel({
    this.id,
    this.key,
    this.temp,
    this.url,
    this.createdAt,
  });

  factory RequestFileModel.fromJson(Map<String, dynamic> json) => _$RequestFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestFileModelToJson(this);
}
