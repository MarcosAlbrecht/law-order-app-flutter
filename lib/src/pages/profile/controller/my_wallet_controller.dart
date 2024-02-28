import 'package:app_law_order/src/models/wallet_model.dart';
import 'package:app_law_order/src/pages/profile/repository/profile_repository.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';

class MyWalletController extends GetxController {
  final profileRepository = ProfileRepository();
  final utilServices = UtilServices();

  WalletModel wallet = WalletModel();

  bool isLoading = true;

  @override
  void onInit() {
    loadWallet();
    super.onInit();
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> loadWallet() async {
    setLoading(true);
    final result = await profileRepository.getWallet();
    setLoading(false);
    result.when(success: (data) {
      wallet = data;
    }, error: (message) {
      utilServices.showToast(message: message, isError: true);
    });
  }

  void handleRequestWithdrawal() {
    if (wallet.realizado! <= 0) {
      utilServices.showToast(message: "Não possui saldo suficiente para solicitar saque.");
    } else {
      Get.toNamed(PagesRoutes.withdrawScreen);
    }
  }
}
