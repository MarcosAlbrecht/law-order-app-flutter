import 'package:app_law_order/src/pages/requests/controller/request_controller.dart';
import 'package:get/get.dart';

class RequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RequestController());
  }
}
