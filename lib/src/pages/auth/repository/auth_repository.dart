import 'dart:async';

import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/cep_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/result/cep_result.dart';
import 'package:app_law_order/src/pages/auth/result/forgot_password_result.dart';
import 'package:app_law_order/src/pages/auth/result/sign_in_result.dart';

import 'package:app_law_order/src/services/http_manager.dart';
import 'package:get/get.dart';

class AuthRepository {
  final HttpManager httpManager = HttpManager();

  //Realiza o login com email e senha
  Future<SignInResult> signIn(
      {required String email, required String password}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.post,
      url: EndPoints.signin,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (result != null && result['statusCode'] == null) {
      var userData = result as Map<String, dynamic>;
      UserModel data = UserModel.fromJson(userData);
      return SignInResult.success(data);
    } else if (result['statusCode'] != null && result['statusCode'] == 401) {
      return SignInResult.error('E-mail ou senha inválidos');
    }

    throw Exception(
        'Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
  }

  Future<ForgotPasswordResult> forgotPassword({required String email}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.post,
      url: EndPoints.forgotPassword,
      body: {
        'email': email,
      },
    );

    if (result.toString().isEmpty) {
      return ForgotPasswordResult.success(
          "Um link de recuperação foi enviado para o seu e-mail");
    } else if (result['statusCode'] == 404) {
      return ForgotPasswordResult.error("E-mail não cadastrado!");
    }

    throw Exception(
        'Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
  }

  Future<CepResult> getCep({required String cep}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: '${EndPointsViaCep.cep}$cep/json',
    );

    if (result['cep'] != null) {
      var cep = result as Map<String, dynamic>;
      CepModel data = CepModel.fromJson(cep);
      return CepResult.success(data);
    } else {
      return CepResult.error("Cep inválido");
    }
  }
}
