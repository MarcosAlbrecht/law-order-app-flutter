// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommentModel _$PostCommentModelFromJson(Map<String, dynamic> json) =>
    PostCommentModel(
      id: json['_id'] as String?,
      comment: json['comment'] as String?,
      postId: json['postId'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostCommentModelToJson(PostCommentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'comment': instance.comment,
      'postId': instance.postId,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'user': instance.user,
    };
