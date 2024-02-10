import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_result.freezed.dart';

@freezed
class ChatsMessageResult<T> with _$ChatsMessageResult<T> {
  factory ChatsMessageResult.success(List<T> data) = Success;
  factory ChatsMessageResult.error(String message) = Error;
}
