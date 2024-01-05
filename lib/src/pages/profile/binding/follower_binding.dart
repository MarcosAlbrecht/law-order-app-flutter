import 'package:app_law_order/src/pages/profile/controller/follower_controller.dart';
import 'package:get/get.dart';

class FollowerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FollowerController());
  }
}
