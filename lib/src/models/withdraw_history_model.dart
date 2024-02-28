// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'withdraw_history_model.g.dart';

@JsonSerializable()
class WithdrawHistoryModel {
  String? createdAt;
  double? value;
  String? status;
  String? updatedAt;

  double? realizado;
  double? taxa;
  double? bloqueado;
  double? total;
  WithdrawHistoryModel({
    this.createdAt,
    this.value,
    this.status,
    required this.updatedAt,
  });

  factory WithdrawHistoryModel.fromJson(Map<String, dynamic> json) => _$WithdrawHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawHistoryModelToJson(this);
}
