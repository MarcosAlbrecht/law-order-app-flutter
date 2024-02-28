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
      providerSetCompleted: json['providerSetCompleted'] as bool?,
      serviceCompleted: json['serviceCompleted'] as bool?,
      deadline: json['deadline'] as String?,
      providerAcceptanceDate: json['providerAcceptanceDate'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      requester: json['requester'] == null
          ? null
          : UserModel.fromJson(json['requester'] as Map<String, dynamic>),
      requested: json['requested'] == null
          ? null
          : UserModel.fromJson(json['requested'] as Map<String, dynamic>),
      paid: json['paid'] as bool? ?? false,
      statusPortuguese: json['statusPortuguese'] == null
          ? null
          : StatusInfoModel.fromJson(
              json['statusPortuguese'] as Map<String, dynamic>),
      files: json['files'] as List<dynamic>?,
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
      'providerSetCompleted': instance.providerSetCompleted,
      'serviceCompleted': instance.serviceCompleted,
      'deadline': instance.deadline,
      'providerAcceptanceDate': instance.providerAcceptanceDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'requester': instance.requester,
      'requested': instance.requested,
      'paid': instance.paid,
      'statusPortuguese': instance.statusPortuguese,
      'files': instance.files,
    };
