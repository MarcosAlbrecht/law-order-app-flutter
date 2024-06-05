// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_comment_model.g.dart';

@JsonSerializable()
class PostCommentModel {
  @JsonKey(name: '_id')
  String? id;
  String? comment;
  String? postId;
  String? userId;
  String? createdAt;
  UserModel? user;
  PostCommentModel({
    this.id,
    this.comment,
    this.postId,
    this.userId,
    this.createdAt,
    this.user,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) => _$PostCommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostCommentModelToJson(this);
}
