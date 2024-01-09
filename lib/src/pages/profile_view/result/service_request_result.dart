import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_request_result.freezed.dart';

@freezed
class ServiceRequestResult with _$ServiceRequestResult {
  factory ServiceRequestResult.success(bool data) = Success;
  factory ServiceRequestResult.error(String message) = Error;
}
