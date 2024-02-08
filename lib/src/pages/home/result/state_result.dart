import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_result.freezed.dart';

@freezed
class StateResult<T> with _$StateResult<T> {
  factory StateResult.success(List<T> data) = Success;
  factory StateResult.error(String message) = Error;
}
