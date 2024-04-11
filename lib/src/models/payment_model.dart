// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/file_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class PaymentModel {
  @JsonKey(name: '_id')
  String? id;
  String? status;
  String? preferenceId;
  String? link;
  String? destinationUserPayment;
  double? value;
  PaymentModel({
    this.id,
    this.status,
    this.preferenceId,
    this.link,
    this.destinationUserPayment,
    this.value,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
