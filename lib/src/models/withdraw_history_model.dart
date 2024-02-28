// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'withdraw_history_model.g.dart';

@JsonSerializable()
class WithdrawHistoryModel {
  @JsonKey(name: '_id')
  String? id;
  String? createdAt;
  String? userId;
  double? value;
  String? status;
  String? updatedAt;
  String? pix;
  WithdrawHistoryModel({
    this.id,
    this.createdAt,
    this.userId,
    this.value,
    this.status,
    this.updatedAt,
    this.pix,
  });

  factory WithdrawHistoryModel.fromJson(Map<String, dynamic> json) => _$WithdrawHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawHistoryModelToJson(this);
}
