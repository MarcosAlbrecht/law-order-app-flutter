import 'package:app_law_order/src/pages/requests/controller/request_manager_controller.dart';
import 'package:get/get.dart';

class RequestManagerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RequestManagerController());
  }
}
