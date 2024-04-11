// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      id: json['_id'] as String?,
      status: json['status'] as String?,
      preferenceId: json['preferenceId'] as String?,
      link: json['link'] as String?,
      destinationUserPayment: json['destinationUserPayment'] as String?,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'preferenceId': instance.preferenceId,
      'link': instance.link,
      'destinationUserPayment': instance.destinationUserPayment,
      'value': instance.value,
    };
