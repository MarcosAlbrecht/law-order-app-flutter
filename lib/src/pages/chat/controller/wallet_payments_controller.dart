import 'package:app_law_order/src/models/fast_payment_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/chat/repository/chat_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';

class WalletPaymentsController extends GetxController {
  final chatRepository = ChatRepository();
  final utilServices = UtilServices();

  List<FastPaymentModel> listPayments = [];
  late UserModel user;

  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>;
    user = arguments['user'];

    getPaymentsWallet();
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getPaymentsWallet() async {
    setLoading(true);
    final result = await chatRepository.getPaymentsWallet(userDestinationId: user.id!);
    setLoading(false);
    result.when(
      success: (data) {
        listPayments = data;
      },
      error: (message) {},
    );
  }

  Future<void> releasePayment() async {
    // final result = await chatRepository.getPaymentsWallet(userDestinationId: user.id!);
    // setLoading(false);
    // result.when(
    //   success: (data) {
    //     getPaymentsWallet();
    //   },
    //   error: (message) {},
    // );
  }
}
