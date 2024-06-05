// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLikeModel _$PostLikeModelFromJson(Map<String, dynamic> json) =>
    PostLikeModel(
      id: json['_id'] as String?,
      postId: json['postId'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostLikeModelToJson(PostLikeModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'postId': instance.postId,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'user': instance.user,
    };
