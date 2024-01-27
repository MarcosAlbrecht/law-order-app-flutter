import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_result.freezed.dart';

@freezed
class NotificationsResult<T> with _$NotificationsResult<T> {
  factory NotificationsResult.success(List<T> data) = Success;
  factory NotificationsResult.error(String message) = Error;
}
