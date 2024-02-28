import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/models/status_info_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_model.g.dart';

@JsonSerializable()
class RequestModel {
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
  @JsonKey(name: 'paid', defaultValue: false)
  bool paid;
  StatusInfoModel? statusPortuguese;
  List<dynamic>? files;
  RequestModel({
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
    this.paid = false,
    this.statusPortuguese,
    this.files,
  });
  //List<FileModel>? files;

  factory RequestModel.fromJson(Map<String, dynamic> json) => _$RequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestModelToJson(this);
}
