import 'package:app_law_order/src/pages/profile/controller/follows_controller.dart';
import 'package:get/get.dart';

class FollowsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FollowsController());
  }
}
