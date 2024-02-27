import 'package:freezed_annotation/freezed_annotation.dart';

part 'pix_result.freezed.dart';

@freezed
class PixResult with _$PixResult {
  factory PixResult.success(String data) = Success;
  factory PixResult.error(String message) = Error;
}
