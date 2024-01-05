import 'package:app_law_order/src/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_view_result.freezed.dart';

@freezed
class ProfileViewResult with _$ProfileViewResult {
  factory ProfileViewResult.success(UserModel data) = Success;
  factory ProfileViewResult.error(String message) = Error;
}
