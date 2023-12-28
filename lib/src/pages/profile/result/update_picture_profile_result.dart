import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_picture_profile_result.freezed.dart';

@freezed
class UpdateProfilePictureResult with _$UpdateProfilePictureResult {
  factory UpdateProfilePictureResult.success(bool data) = Success;
  factory UpdateProfilePictureResult.error(bool message) = Error;
}
