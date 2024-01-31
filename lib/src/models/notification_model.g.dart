// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['_id'] as String?,
      read: json['read'] as bool?,
      link: json['link'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'read': instance.read,
      'link': instance.link,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'metadata': instance.metadata,
      'message': instance.message,
    };
