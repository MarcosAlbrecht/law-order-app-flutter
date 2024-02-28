import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_file_request_result.freezed.dart';

@freezed
class DownloadFileRequestResult<T> with _$DownloadFileRequestResult<T> {
  factory DownloadFileRequestResult.success(String data) = Success;
  factory DownloadFileRequestResult.error(String message) = Error;
}
