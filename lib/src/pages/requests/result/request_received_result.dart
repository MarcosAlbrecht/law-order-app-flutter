import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_received_result.freezed.dart';

@freezed
class RequestReceivedResult<T> with _$RequestReceivedResult<T> {
  factory RequestReceivedResult.success(List<T> data) = Success;
  factory RequestReceivedResult.error(String message) = Error;
}
