import 'package:app_law_order/src/models/request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'acceptance_request_result.freezed.dart';

@freezed
class AcceptanceRequestResult with _$AcceptanceRequestResult {
  factory AcceptanceRequestResult.success(RequestModel data) = Success;
  factory AcceptanceRequestResult.error(String message) = Error;
}
