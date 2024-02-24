import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile/repository/profile_repository.dart';
import 'package:get/get.dart';

class WithDrawController extends GetxController {
  final profileRepository = ProfileRepository();
  final authController = Get.find<AuthController>();

  bool isSaving = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadWithdraws() async {}
}
