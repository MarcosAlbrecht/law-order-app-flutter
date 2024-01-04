import 'package:freezed_annotation/freezed_annotation.dart';

part 'follows_result.freezed.dart';

@freezed
class FollowsResult<T> with _$FollowsResult<T> {
  factory FollowsResult.success(List<T> data) = Success;
  factory FollowsResult.error(String message) = Error;
}
