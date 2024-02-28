// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      id: json['_id'] as String?,
      message: json['message'] as String?,
      destinationUserId: json['destinationUserId'] as String?,
      seen: json['seen'] as bool?,
      authorFirstName: json['authorFirstName'] as String?,
      file: json['file'] == null
          ? null
          : FileModel.fromJson(json['file'] as Map<String, dynamic>),
      authorLastName: json['authorLastName'] as String?,
      authorProfilePictureUrl: json['authorProfilePictureUrl'] as String?,
      chatId: json['chatId'] as String?,
      userId: json['userId'] as String?,
      fileName: json['fileName'] as String?,
      createdAt: json['createdAt'] as String?,
      files: json['files'] == null
          ? null
          : FileModel.fromJson(json['files'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'message': instance.message,
      'destinationUserId': instance.destinationUserId,
      'seen': instance.seen,
      'authorFirstName': instance.authorFirstName,
      'file': instance.file,
      'authorLastName': instance.authorLastName,
      'authorProfilePictureUrl': instance.authorProfilePictureUrl,
      'chatId': instance.chatId,
      'userId': instance.userId,
      'fileName': instance.fileName,
      'createdAt': instance.createdAt,
      'files': instance.files,
    };
