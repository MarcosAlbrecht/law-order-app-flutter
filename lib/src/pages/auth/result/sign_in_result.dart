import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app_law_order/src/models/user_model.dart';

part 'sign_in_result.freezed.dart';

@freezed
class SignInResult with _$SignInResult {
  factory SignInResult.success(UserModel data) = Success;
  factory SignInResult.error(String message) = Error;
}
