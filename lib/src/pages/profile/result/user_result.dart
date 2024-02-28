import 'package:app_law_order/src/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_result.freezed.dart';

@freezed
class UserResult with _$UserResult {
  factory UserResult.success(UserModel data) = Success;
  factory UserResult.error(String message) = Error;
}
