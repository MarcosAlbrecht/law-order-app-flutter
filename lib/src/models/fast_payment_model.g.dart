// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fast_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FastPaymentModel _$FastPaymentModelFromJson(Map<String, dynamic> json) =>
    FastPaymentModel(
      id: json['_id'] as String?,
      message: json['message'] as String?,
      destinationUserId: json['destinationUserId'] as String?,
      seen: json['seen'] as bool?,
      authorFirstName: json['authorFirstName'] as String?,
      payment: json['payment'] == null
          ? null
          : PaymentModel.fromJson(json['payment'] as Map<String, dynamic>),
      file: json['file'] == null
          ? null
          : FileModel.fromJson(json['file'] as Map<String, dynamic>),
      authorLastName: json['authorLastName'] as String?,
      authorProfilePictureUrl: json['authorProfilePictureUrl'] as String?,
      chatId: json['chatId'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] as String?,
      emailSent: json['emailSent'] as bool?,
    );

Map<String, dynamic> _$FastPaymentModelToJson(FastPaymentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'message': instance.message,
      'destinationUserId': instance.destinationUserId,
      'seen': instance.seen,
      'authorFirstName': instance.authorFirstName,
      'payment': instance.payment,
      'file': instance.file,
      'authorLastName': instance.authorLastName,
      'authorProfilePictureUrl': instance.authorProfilePictureUrl,
      'chatId': instance.chatId,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'emailSent': instance.emailSent,
    };
