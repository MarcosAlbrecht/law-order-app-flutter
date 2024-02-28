import 'package:app_law_order/src/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdraw_profile_result.freezed.dart';

@freezed
class WithdrawProfileResult<T> with _$WithdrawProfileResult<T> {
  factory WithdrawProfileResult.success(List<T> data) = Success;
  factory WithdrawProfileResult.error(String message) = Error;
}
