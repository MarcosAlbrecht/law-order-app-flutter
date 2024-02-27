import 'package:app_law_order/src/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdraw_profile_result.freezed.dart';

@freezed
class WithdrawProfileResult with _$WithdrawProfileResult {
  factory WithdrawProfileResult.success(UserModel data) = Success;
  factory WithdrawProfileResult.error(String message) = Error;
}
