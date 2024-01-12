// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestModel _$RequestModelFromJson(Map<String, dynamic> json) => RequestModel(
      id: json['_id'] as String?,
      requesterId: json['requesterId'] as String?,
      requestedId: json['requestedId'] as String?,
      requestDescription: json['requestDescription'] as String?,
      requestUrgency: json['requestUrgency'] as String?,
      status: json['status'] as String?,
      dateForService: json['dateForService'] as String?,
      requestedServices: (json['requestedServices'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toDouble(),
      providerAcceptance: json['providerAcceptance'] as bool?,
      applicantsAcceptance: json['applicantsAcceptance'] as bool?,
      canceled: json['canceled'] as bool?,
      createdAt: json['createdAt'] as String?,
      requester: json['requester'] == null
          ? null
          : UserModel.fromJson(json['requester'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestModelToJson(RequestModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'requesterId': instance.requesterId,
      'requestedId': instance.requestedId,
      'requestDescription': instance.requestDescription,
      'requestUrgency': instance.requestUrgency,
      'status': instance.status,
      'dateForService': instance.dateForService,
      'requestedServices': instance.requestedServices,
      'total': instance.total,
      'providerAcceptance': instance.providerAcceptance,
      'applicantsAcceptance': instance.applicantsAcceptance,
      'canceled': instance.canceled,
      'createdAt': instance.createdAt,
      'requester': instance.requester,
    };
