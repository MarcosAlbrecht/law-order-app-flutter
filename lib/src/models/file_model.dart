// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'file_model.g.dart';

@JsonSerializable()
class FileModel {
  @JsonKey(name: '_id')
  String? id;
  String? key;
  bool? temp;
  String? url;
  String? createdAt;
  String? fileLocalPath;
  FileModel({
    this.id,
    this.key,
    this.temp,
    this.url,
    this.createdAt,
    this.fileLocalPath,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}
