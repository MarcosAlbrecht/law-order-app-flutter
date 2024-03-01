import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_withdraw_result.freezed.dart';

@freezed
class RequestWithdrawResult with _$RequestWithdrawResult {
  factory RequestWithdrawResult.success(String data) = Success;
  factory RequestWithdrawResult.error(String message) = Error;
}
