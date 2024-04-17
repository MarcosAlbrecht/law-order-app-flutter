import 'package:freezed_annotation/freezed_annotation.dart';

part 'payments_wallet_result.freezed.dart';

@freezed
class PaymentsWalletResult<T> with _$PaymentsWalletResult<T> {
  factory PaymentsWalletResult.success(List<T> data) = Success;
  factory PaymentsWalletResult.error(String message) = Error;
}
