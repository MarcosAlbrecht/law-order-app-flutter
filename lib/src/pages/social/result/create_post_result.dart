import 'package:app_law_order/src/models/post_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_result.freezed.dart';

@freezed
class CreatePostResult with _$CreatePostResult {
  factory CreatePostResult.success(PostModel data) = Success;
  factory CreatePostResult.error(String message) = Error;
}
