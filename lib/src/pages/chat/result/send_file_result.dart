import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_file_result.freezed.dart';

@freezed
class SendFileResult with _$SendFileResult {
  factory SendFileResult.success(String data) = Success;
  factory SendFileResult.error(String message) = Error;
}
