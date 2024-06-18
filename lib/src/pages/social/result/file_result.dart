import 'package:app_law_order/src/models/file_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_result.freezed.dart';

@freezed
class FileResult with _$FileResult {
  factory FileResult.success(FileModel data) = Success;
  factory FileResult.error(String message) = Error;
}
