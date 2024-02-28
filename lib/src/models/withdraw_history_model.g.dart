// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawHistoryModel _$WithdrawHistoryModelFromJson(
        Map<String, dynamic> json) =>
    WithdrawHistoryModel(
      createdAt: json['createdAt'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      status: json['status'] as String?,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$WithdrawHistoryModelToJson(
        WithdrawHistoryModel instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'value': instance.value,
      'status': instance.status,
      'updatedAt': instance.updatedAt,
    };
