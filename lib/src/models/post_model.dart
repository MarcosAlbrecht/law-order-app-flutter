// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/picture_model.dart';
import 'package:app_law_order/src/models/post_comment_model.dart';
import 'package:app_law_order/src/models/post_like_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  @JsonKey(name: '_id')
  String? id;
  String? description;
  List<String>? photosIds;
  List<String>? videoIds;
  String? ownerId;
  UserModel? owner;
  String? createdAt;
  String? updatedAt;
  List<PostLikeModel>? likes;
  List<PostCommentModel>? comments;
  List<PictureModel>? photos;
  List<PictureModel>? videos;
  PostModel({
    this.id,
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
