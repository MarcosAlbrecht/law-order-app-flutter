// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawHistoryModel _$WithdrawHistoryModelFromJson(
        Map<String, dynamic> json) =>
    WithdrawHistoryModel(
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      userId: json['userId'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      status: json['status'] as String?,
      updatedAt: json['updatedAt'] as String?,
      pix: json['pix'] as String?,
    );

Map<String, dynamic> _$WithdrawHistoryModelToJson(
        WithdrawHistoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'userId': instance.userId,
      'value': instance.value,
      'status': instance.status,
      'updatedAt': instance.updatedAt,
      'pix': instance.pix,
    };
