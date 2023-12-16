import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isWork = false.obs;

  Future<void> signIn({required String email, required String password}) async {
    //chamar a api para efetuar login
  }

  Future<void> handleSignUp() async {
    //chamar a api para efetuar login
  }

  Future<void> signUpStep1() async {
    Get.toNamed(PagesRoutes.signUpStep1);
  }
}
