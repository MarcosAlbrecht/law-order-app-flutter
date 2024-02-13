import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_file_result.freezed.dart';

@freezed
class DownloadFileResult<T> with _$DownloadFileResult<T> {
  factory DownloadFileResult.success(String data) = Success;
  factory DownloadFileResult.error(String message) = Error;
}
