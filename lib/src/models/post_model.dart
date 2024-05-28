// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/picture_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  String? sId;
  String? description;
  List<String>? photosIds;
  List<String>? videoIds;
  String? ownerId;
  UserModel? owner;
  String? createdAt;
  String? updatedAt;
  List<UserModel>? likes;
  List<UserModel>? comments;
  List<PictureModel>? photos;
  List<PictureModel>? videos;
  PostModel({
    this.sId,
    this.description,
    this.photosIds,
    this.videoIds,
    this.ownerId,
    this.owner,
    this.createdAt,
    this.updatedAt,
    this.likes,
    this.comments,
    this.photos,
    this.videos,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
