import 'package:freezed_annotation/freezed_annotation.dart';

part 'chats_result.freezed.dart';

@freezed
class ChatsResult<T> with _$ChatsResult<T> {
  factory ChatsResult.success(List<T> data) = Success;
  factory ChatsResult.error(String message) = Error;
}
