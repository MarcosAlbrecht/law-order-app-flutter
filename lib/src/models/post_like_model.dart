// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_like_model.g.dart';

@JsonSerializable()
class PostLikeModel {
  @JsonKey(name: '_id')
  String? id;
  String? postId;
  String? userId;
  String? createdAt;
  UserModel? user;
  PostLikeModel({
    this.id,
    this.postId,
    this.userId,
    this.createdAt,
    this.user,
  });

  factory PostLikeModel.fromJson(Map<String, dynamic> json) => _$PostLikeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostLikeModelToJson(this);
}
