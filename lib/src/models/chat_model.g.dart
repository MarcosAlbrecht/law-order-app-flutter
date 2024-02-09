// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      id: json['id'] as String?,
      chatId: json['chatId'] as String?,
      destinationUserId: json['destinationUserId'] as String?,
      message: json['message'] as String?,
      createdAt: json['createdAt'] as String?,
      seen: json['seen'] as bool?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      destinationUser: json['destinationUser'] == null
          ? null
          : UserModel.fromJson(json['destinationUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'destinationUserId': instance.destinationUserId,
      'message': instance.message,
      'createdAt': instance.createdAt,
      'seen': instance.seen,
      'user': instance.user,
      'destinationUser': instance.destinationUser,
    };
