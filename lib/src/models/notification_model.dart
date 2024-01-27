// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'read')
  bool? read;
  @JsonKey(name: 'link')
  String? link;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'metadata')
  String? metadata;
  @JsonKey(name: 'message')
  String? message;
  NotificationModel({
    this.id,
    this.read,
    this.link,
    this.userId,
    this.createdAt,
    this.metadata,
    this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  String toString() {
    return 'NotificationModel(id: $id, read: $read, link: $link, userId: $userId, createdAt: $createdAt, metadata: $metadata)';
  }
}
