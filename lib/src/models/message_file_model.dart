// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'message_file_model.g.dart';

@JsonSerializable()
class MessageFileModel {
  @JsonKey(name: '_id')
  String? id;
  String? key;
  String? temp;
  String? url;
  String? createdAt;
  MessageFileModel({
    this.id,
    this.key,
    this.temp,
    this.url,
    this.createdAt,
  });

  factory MessageFileModel.fromJson(Map<String, dynamic> json) => _$MessageFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageFileModelToJson(this);
}
