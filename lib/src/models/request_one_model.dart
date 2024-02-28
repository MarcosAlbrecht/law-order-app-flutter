// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/file_model.dart';
import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/models/status_info_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_one_model.g.dart';

@JsonSerializable()
class RequestOneModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'requesterId')
  String? requesterId;
  @JsonKey(name: 'requestedId')
  String? requestedId;
  @JsonKey(name: 'requestDescription')
  String? requestDescription;
  @JsonKey(name: 'requestUrgency')
  String? requestUrgency;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'dateForService')
  String? dateForService;
  @JsonKey(name: 'requestedServices')
  List<ServiceModel>? requestedServices;
  @JsonKey(name: 'total')
  double? total;
  @JsonKey(name: 'providerAcceptance')
  bool? providerAcceptance;
  @JsonKey(name: 'applicantsAcceptance')
  bool? applicantsAcceptance;
  @JsonKey(name: 'canceled')
  bool? canceled;
  @JsonKey(name: 'providerSetCompleted')
  bool? providerSetCompleted;
  @JsonKey(name: 'serviceCompleted')
  bool? serviceCompleted;
  @JsonKey(name: 'deadline')
  String? deadline;
  @JsonKey(name: 'providerAcceptanceDate')
  String? providerAcceptanceDate;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'requester')
  UserModel? requester;
  @JsonKey(name: 'requested')
  UserModel? requested;
  @JsonKey(name: 'paymentId')
  UserModel? paymentId;
  StatusInfoModel? statusPortuguese;
  List<FileModel>? files;

  RequestOneModel({
    this.id,
    this.requesterId,
    this.requestedId,
    this.requestDescription,
    this.requestUrgency,
    this.status,
    this.dateForService,
    this.requestedServices,
    this.total,
    this.providerAcceptance,
    this.applicantsAcceptance,
    this.canceled,
    this.providerSetCompleted,
    this.serviceCompleted,
    this.deadline,
    this.providerAcceptanceDate,
    this.createdAt,
    this.updatedAt,
    this.requester,
    this.requested,
    this.paymentId,
    this.statusPortuguese,
    this.files,
  });

  factory RequestOneModel.fromJson(Map<String, dynamic> json) => _$RequestOneModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOneModelToJson(this);
}
