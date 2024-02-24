import 'package:app_law_order/src/pages/profile/controller/withdraw_controller.dart';
import 'package:get/get.dart';

class WithdrawBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(WithDrawController());
  }
}
