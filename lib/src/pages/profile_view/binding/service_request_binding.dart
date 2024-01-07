import 'package:app_law_order/src/pages/profile_view/controller/service_request_controller.dart';
import 'package:get/get.dart';

class ServiceRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ServiceRequestController());
  }
}
