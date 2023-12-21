import 'package:app_law_order/src/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_result.freezed.dart';

@freezed
class SignUpResult with _$SignUpResult {
  factory SignUpResult.success(UserModel data) = Success;
  factory SignUpResult.error(String message) = Error;
}
