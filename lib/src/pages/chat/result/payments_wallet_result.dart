import 'package:app_law_order/src/models/fast_payment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payments_wallet_result.freezed.dart';

@freezed
class PaymentsWalletResult with _$PaymentsWalletResult {
  factory PaymentsWalletResult.success(FastPaymentModel data) = Success;
  factory PaymentsWalletResult.error(String message) = Error;
}
