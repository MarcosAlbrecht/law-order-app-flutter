import 'package:app_law_order/src/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_user_result.freezed.dart';

@freezed
class ProfileUserResult with _$ProfileUserResult {
  factory ProfileUserResult.success(UserModel data) = Success;
  factory ProfileUserResult.error(String message) = Error;
}
