import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_link_result.freezed.dart';

@freezed
class PaymentLinkResult with _$PaymentLinkResult {
  factory PaymentLinkResult.success(String data) = Success;
  factory PaymentLinkResult.error(String message) = Error;
}
