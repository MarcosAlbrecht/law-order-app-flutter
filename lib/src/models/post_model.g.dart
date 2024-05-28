// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      sId: json['sId'] as String?,
      description: json['description'] as String?,
      photosIds: (json['photosIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      videoIds: (json['videoIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ownerId: json['ownerId'] as String?,
      owner: json['owner'] == null
          ? null
          : UserModel.fromJson(json['owner'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      likes: (json['likes'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => PictureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      videos: (json['videos'] as List<dynamic>?)
          ?.map((e) => PictureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'sId': instance.sId,
      'description': instance.description,
      'photosIds': instance.photosIds,
      'videoIds': instance.videoIds,
      'ownerId': instance.ownerId,
      'owner': instance.owner,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'likes': instance.likes,
      'comments': instance.comments,
      'photos': instance.photos,
      'videos': instance.videos,
    };
