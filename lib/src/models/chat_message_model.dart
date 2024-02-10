// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:app_law_order/src/models/message_file_model.dart';

part 'chat_message_model.g.dart';

@JsonSerializable()
class ChatMessageModel {
  @JsonKey(name: '_id')
  String? id;
  String? message;
  String? destinationUserId;
  bool? seen;
  String? authorFirstName;
  MessageFileModel? file;
  String? authorLastName;
  String? authorProfilePictureUrl;
  String? chatId;
  String? userId;
  String? fileName;
  String? createdAt;

  ChatMessageModel({
    this.id,
    this.message,
    this.destinationUserId,
    this.seen,
    this.authorFirstName,
    this.file,
    this.authorLastName,
    this.authorProfilePictureUrl,
    this.chatId,
    this.userId,
    this.fileName,
    this.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => _$ChatMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}
