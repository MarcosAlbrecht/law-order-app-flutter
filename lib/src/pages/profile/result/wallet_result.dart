import 'package:app_law_order/src/models/wallet_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_result.freezed.dart';

@freezed
class WalletResult with _$WalletResult {
  factory WalletResult.success(WalletModel data) = Success;
  factory WalletResult.error(String message) = Error;
}
