// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follows_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowsModel _$FollowsModelFromJson(Map<String, dynamic> json) => FollowsModel(
      id: json['_id'] as String?,
      followerId: json['followerId'] as String?,
      followedId: json['followedId'] as String?,
      followed: json['followed'] == null
          ? null
          : UserModel.fromJson(json['followed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FollowsModelToJson(FollowsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'followerId': instance.followerId,
      'followedId': instance.followedId,
      'followed': instance.followed,
    };
