import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_result.freezed.dart';

@freezed
class FileResult with _$FileResult {
  factory FileResult.success(String data) = Success;
  factory FileResult.error(String message) = Error;
}
