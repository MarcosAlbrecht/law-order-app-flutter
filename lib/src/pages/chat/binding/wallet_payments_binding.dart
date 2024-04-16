import 'package:app_law_order/src/pages/chat/controller/wallet_payments_controller.dart';
import 'package:get/get.dart';

class PaymentsWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WalletPaymentsController());
  }
}
