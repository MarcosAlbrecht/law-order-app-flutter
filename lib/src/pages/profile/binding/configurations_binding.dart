import 'package:app_law_order/src/pages/profile/controller/configurations_controller.dart';
import 'package:get/get.dart';

class ConfigurationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ConfigurationsController());
  }
}
