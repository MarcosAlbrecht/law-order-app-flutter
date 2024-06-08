import 'package:app_law_order/src/models/post_comment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_result.freezed.dart';

@freezed
class CommentResult with _$CommentResult {
  factory CommentResult.success(PostCommentModel data) = Success;
  factory CommentResult.error(String message) = Error;
}
