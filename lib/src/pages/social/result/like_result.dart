import 'package:app_law_order/src/models/post_like_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_result.freezed.dart';

@freezed
class LikeResult with _$LikeResult {
  factory LikeResult.success(PostLikeModel data) = Success;
  factory LikeResult.error(String message) = Error;
}
