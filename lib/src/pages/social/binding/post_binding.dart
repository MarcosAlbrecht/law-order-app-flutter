import 'package:app_law_order/src/pages/social/controller/post_controller.dart';
import 'package:get/get.dart';

class PostBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
  }
}
