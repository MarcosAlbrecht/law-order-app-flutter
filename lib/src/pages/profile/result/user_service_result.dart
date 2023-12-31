import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_service_result.freezed.dart';

@freezed
class UserServiceResult with _$UserServiceResult {
  factory UserServiceResult.success(bool data) = Success;
  factory UserServiceResult.error(String message) = Error;
}
