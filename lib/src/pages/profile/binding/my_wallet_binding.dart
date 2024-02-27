import 'package:app_law_order/src/pages/profile/controller/my_wallet_controller.dart';
import 'package:get/get.dart';

class MyWalletBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MyWalletController());
  }
}
