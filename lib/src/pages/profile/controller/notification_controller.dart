import 'package:app_law_order/src/models/notification_model.dart';
import 'package:app_law_order/src/pages/profile/repository/profile_repository.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:app_law_order/src/pages/requests/repository/request_repository.dart';
import 'package:get/get.dart';

const int itemsPerPage = 10;

class NotificationController extends GetxController {
  final profileRepository = ProfileRepository();

  List<NotificationModel>? currentListNotifications;
  List<NotificationModel> notifications = [];

  bool isLoading = false;
  bool isSaving = false;

  int pagination = 0;

  bool get isLastPage {
    if (currentListNotifications!.length < itemsPerPage) return true;

    return pagination + itemsPerPage > notifications.length;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loadNotifications();
  }

  void setLoading(bool value, {bool isUser = false}) {
    if (isUser) {
      isLoading = value;
    }
    update();
  }

  void setSaving(bool value) {
    isLoading = value;
    update();
  }

  Future<void> loadNotifications({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isUser: true);
    }

    final result = await profileRepository.getNotifications(
        limit: itemsPerPage, skip: pagination);

    setLoading(false, isUser: true);

    result.when(
      success: (data) {
        currentListNotifications = data;
        notifications.addAll(currentListNotifications!);
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
  }

  void loadMoreNotifications() {
    pagination = pagination + 10;
    loadNotifications(canLoad: false);
  }

  Future<void> updateNotificationList(NotificationModel notification) async {
    setSaving(true);
    for (var notifi in notifications) {
      if (notifi.id == notification.id) {
        notifi.read = true;
        break;
      }
    }
    setSaving(false);
  }

  Future<void> handleReadNotification(
      {required NotificationModel notification}) async {
    setSaving(true);
    final result = await profileRepository.updateNotification(
        notificationID: notification.id!);
    setSaving(false);
    result.when(
      success: (data) {
        updateNotificationList(notification);
      },
      error: (message) {},
    );
  }
}
