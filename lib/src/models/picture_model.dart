// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'picture_model.g.dart';

@JsonSerializable()
class PictureModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'key')
  String? key;
  @JsonKey(name: 'temp')
  bool? name;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'localPath')
  String? localPath;
  @JsonKey(name: 'status')
  String? status;
  PictureModel({
    this.id,
    this.key,
    this.name,
    this.url,
    this.localPath,
    this.status,
  });

  factory PictureModel.fromJson(Map<String, dynamic> json) =>
      _$PictureModelFromJson(json);

  Map<String, dynamic> toJson() => _$PictureModelToJson(this);

  @override
  String toString() {
    return 'PictureModel(id: $id, key: $key, name: $name, url: $url, localPath: $localPath, status: $status)';
  }
}
