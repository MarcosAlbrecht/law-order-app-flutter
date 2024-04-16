// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/file_model.dart';
import 'package:app_law_order/src/models/payment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fast_payment_model.g.dart';

@JsonSerializable()
class FastPaymentModel {
  @JsonKey(name: '_id')
  String? id;
  String? message;
  String? destinationUserId;
  bool? seen;
  String? authorFirstName;
  PaymentModel? payment;
  FileModel? file;
  String? authorLastName;
  String? authorProfilePictureUrl;
  String? chatId;
  String? userId;
  String? createdAt;
  bool? emailSent;
  FastPaymentModel({
    this.id,
    this.message,
    this.destinationUserId,
    this.seen,
    this.authorFirstName,
    this.payment,
    this.file,
    this.authorLastName,
    this.authorProfilePictureUrl,
    this.chatId,
    this.userId,
    this.createdAt,
    this.emailSent,
  });

  factory FastPaymentModel.fromJson(Map<String, dynamic> json) => _$FastPaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$FastPaymentModelToJson(this);
}
