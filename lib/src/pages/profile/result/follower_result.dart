import 'package:freezed_annotation/freezed_annotation.dart';

part 'follower_result.freezed.dart';

@freezed
class FollowerResult<T> with _$FollowerResult<T> {
  factory FollowerResult.success(List<T> data) = Success;
  factory FollowerResult.error(String message) = Error;
}
