import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_result.freezed.dart';

@freezed
class PostResult<T> with _$PostResult<T> {
  factory PostResult.success(List<T> data) = Success;
  factory PostResult.error(String message) = Error;
}
