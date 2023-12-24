import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  UserModel userModel = UserModel();

  final authController = Get.find<AuthController>();

  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
  }

  void setLoading({required bool value}) {
    isLoading = value;

    update();
  }
}
