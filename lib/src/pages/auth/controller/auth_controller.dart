import 'dart:async';

import 'package:app_law_order/src/config/app_data.dart';
import 'package:app_law_order/src/constants/storage_keys.dart';
import 'package:app_law_order/src/models/occupation_areas_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/repository/auth_repository.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AuthController extends GetxController {
  final authRepository = AuthRepository();
  final utilServices = UtilServices();

  UserModel user = UserModel();

  List<OccupationAreasModel> occupationsAreas = occupationAreas;

  RxBool isLoading = false.obs;
  bool isSaving = false;
  RxBool isWork = false.obs;
  bool isValidCep = false;

  String? confirmPassword;

  @override
  void onInit() {
    super.onInit();

    validateLogin();
    print(occupationsAreas);
  }

  void setSaving(bool value) {
    isSaving = value;
    update();
  }

  void setIsLoading(bool value) {
    isLoading.value = value;
    update();
  }

  Future<void> validateLogin() async {
    String? email = await utilServices.getEmailLocalData();
    String? password = await utilServices.getPasswordlLocalData();
    String? token = await utilServices.getToken();

    if (email.isNotEmpty && password.isNotEmpty) {
      signIn(email: email, password: password);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    setIsLoading(true);
    var result = await authRepository.signIn(email: email, password: password);
    setIsLoading(false);

    result.when(
      success: (data) {
        user = data;
        user.password = password;
        saveTokenAndProceedToBase(user.email!, password, user.accessToken!);
      },
      error: (message) async {
        utilServices.showToast(message: message, isError: true);
        await utilServices.removeLocalData();
      },
    );
  }

  //insere um novo usuario
  Future<void> handleSignUp() async {
    //verifica se as senhas sáo iguais
    if ((user.password != confirmPassword) ||
        user.password == null ||
        confirmPassword == null) {
      utilServices.showToast(message: "A senhas não conferem!");
      return;
    }

    //verifica se o cep foi validado
    if (!isValidCep) {
      utilServices.showToast(message: "CEP inválido!");
      return;
    }

    //formata a data para modelo 10/10/1999
    user.birthday = await utilServices.convertBirthday(user.birthday!);

    setSaving(true);

    //chamar a api para efetuar cadastro
    var result = await authRepository.signUp(user: user);

    result.when(
      success: (data) async {
        utilServices.showToast(message: "Cadastro realizado com sucesso!");
        var password = user.password;
        user = data;
        //realizar o login e salva os dados localmente
        await signIn(email: user.email!, password: password!);
        //saveTokenAndProceedToBase(user.email!, password!, user.accessToken!);
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );

    setSaving(false);
  }

  Future<void> handleProfileEdit() async {
    //verifica se o cep foi validado
    final validCep = await handleValidateCep(cep1: user.cep!);

    if (!validCep) {
      utilServices.showToast(message: "CEP inválido");
      return;
    }

    setSaving(true);

    //chamar a api para editar perfil
    var result = await authRepository.editProfile(user: user);

    setSaving(false);

    result.when(
      success: (data) {
        utilServices.showToast(message: "Cadastro editado com sucesso!");
        var password = user.password;
        user = data;
        //saveTokenAndProceedToBase(user.email!, password!, user.accessToken!);
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );

    isValidCep = false;
  }

  //envia email de recuperaçao de senha
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
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  //valida o cep digitado
  Future<bool> handleValidateCep({required String cep1}) async {
    var cep2 = cep1.replaceAll("-", "");
    var result = await authRepository.getCep(cep: cep2);
    result.when(
      success: (data) {
        isValidCep = true;
        user.city = data.localidade;
        user.state = data.uf;
        user.cep = cep2;
        return true;
      },
      error: (message) {
        isValidCep = false;
        utilServices.showToast(message: message, isError: true);
        return false;
      },
    );
    return true;
  }

  Future<void> getUserById() async {
    final result = await authRepository.getUserById(user: user);
    result.when(
      success: (data) {
        user = data;
      },
      error: (message) {
        utilServices.showToast(message: message);
      },
    );
  }
}
