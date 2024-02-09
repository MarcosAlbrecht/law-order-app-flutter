// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:app_law_order/src/models/user_model.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  @JsonKey(name: 'id')
  String? id;
  String? chatId;
  String? destinationUserId;
  String? message;
  String? createdAt;
  bool? seen;
  UserModel? user;
  UserModel? destinationUser;
  ChatModel({
    this.id,
    this.chatId,
    this.destinationUserId,
    this.message,
    this.createdAt,
    this.seen,
    this.user,
    this.destinationUser,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
