import 'package:app_law_order/src/pages/profile/controller/notification_controller.dart';
import 'package:get/get.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}
