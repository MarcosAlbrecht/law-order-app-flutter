// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowerModel _$FollowerModelFromJson(Map<String, dynamic> json) =>
    FollowerModel(
      id: json['_id'] as String?,
      followerId: json['followerId'] as String?,
      followedId: json['followedId'] as String?,
      follower: json['follower'] == null
          ? null
          : UserModel.fromJson(json['follower'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FollowerModelToJson(FollowerModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'followerId': instance.followerId,
      'followedId': instance.followedId,
      'follower': instance.follower,
    };
