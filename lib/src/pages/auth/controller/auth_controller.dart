import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> signIn({required String email, required String password}) async {
    //chamar a api para efetuar login
  }

  void signUp() {
    Get.toNamed(PagesRoutes.signUpStep1);
  }
}
