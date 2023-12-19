import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_result.freezed.dart';

@freezed
class ForgotPasswordResult with _$ForgotPasswordResult {
  factory ForgotPasswordResult.success(String data) = Success;
  factory ForgotPasswordResult.error(String message) = Error;
}
