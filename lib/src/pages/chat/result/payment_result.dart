import 'package:app_law_order/src/models/payment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_result.freezed.dart';

@freezed
class PaymentResult with _$PaymentResult {
  factory PaymentResult.success(PaymentModel data) = Success;
  factory PaymentResult.error(String message) = Error;
}
