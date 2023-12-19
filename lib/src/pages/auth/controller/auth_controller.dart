import 'package:app_law_order/src/constants/storage_keys.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/repository/auth_repository.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final authRepository = AuthRepository();
  final utilServices = UtilServices();

  UserModel user = UserModel();

  RxBool isLoading = false.obs;
  RxBool isWork = false.obs;

  @override
  void onInit() {
    super.onInit();

    validateLogin();
  }

  Future<void> validateLogin() async {
    String? email = await utilServices.getEmailLocalData();
    String? password = await utilServices.getPasswordlLocalData();
    String? token = await utilServices.getToken();

    if (email.isNotEmpty) {
      signIn(email: email, password: password);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    var result = await authRepository.signIn(email: email, password: password);

    result.when(
      success: (data) {
        user = data;
        saveTokenAndProceedToBase(user.email!, password, user.accessToken!);
      },
      error: (message) async {
        utilServices.showToast(message: message, isError: true);
        await utilServices.removeLocalData();
      },
    );
  }

  Future<void> handleSignUp() async {
    //chamar a api para efetuar cadastro
  }

  Future<void> handleForgotPassword({required String email}) async {
    var result = await authRepository.forgotPassword(email: email);
    result.when(success: (data) {
      utilServices.showToast(message: data);
    }, error: (message) {
      utilServices.showToast(message: message, isError: true);
    });
  }

  void saveTokenAndProceedToBase(String email, String password, String token) {
    //salvar o token
    utilServices.saveLocalData(
      email: email,
      senha: password,
      token: token,
    );
    //ir para a tela base
    //Get.offAllNamed(PagesRoutes.baseRoute);
  }
}
