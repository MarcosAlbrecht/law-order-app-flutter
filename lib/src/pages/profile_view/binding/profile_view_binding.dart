import 'package:app_law_order/src/pages/home/controller/home_controller.dart';
import 'package:app_law_order/src/pages/profile_view/controller/profile_view_controller.dart';
import 'package:get/get.dart';

class ProfileViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileViewController());
  }
}
