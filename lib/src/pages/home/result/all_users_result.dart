import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_users_result.freezed.dart';

@freezed
class AllUsersResult<T> with _$AllUsersResult<T> {
  factory AllUsersResult.success(List<T> data) = Success;
  factory AllUsersResult.error(String message) = Error;
}
