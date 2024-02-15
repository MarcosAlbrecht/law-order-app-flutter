import 'dart:async';

import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/cep_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/result/cep_result.dart';
import 'package:app_law_order/src/pages/auth/result/forgot_password_result.dart';
import 'package:app_law_order/src/pages/auth/result/sign_in_result.dart';
import 'package:app_law_order/src/pages/auth/result/sign_up_result.dart';

import 'package:app_law_order/src/services/http_manager.dart';
import 'package:get/get.dart';

class AuthRepository {
  final HttpManager httpManager = HttpManager();

  //Realiza o login com email e senha
  Future<SignInResult<UserModel>> signIn({required String email, required String password}) async {
    try {
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
      } else {
        return SignInResult.error('Ocorreu um erro inesperado!');
      }
    } catch (error) {
      String errorMessage = error.toString().replaceFirst('Exception: ', '');
      return SignInResult.error(errorMessage);
    }
  }

  Future<SignUpResult> signUp({required UserModel user}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.post,
      url: EndPoints.createUser,
      body: user.toJson(),
    );

    if (result['message'] == null && result['_id'] != null) {
      var userData = result as Map<String, dynamic>;
      UserModel data = UserModel.fromJson(userData);
      return SignUpResult.success(data);
    } else if (result['message'] != null && result['statusCode'] == 409) {
      return SignUpResult.error('Email já cadastrado!');
    }

    throw Exception('Ocorreu um erro ao cadastrar os dados. Tente novamente mais tarde!');
  }

  Future<SignUpResult> getUserById({required UserModel user}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: '${EndPoints.getUserById}${user.id!}',
    );

    if (result['_id'] != null) {
      var userData = result as Map<String, dynamic>;
      UserModel data = UserModel.fromJson(userData);
      return SignUpResult.success(data);
    } else {
      return SignUpResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
    }
  }

  Future<SignUpResult> editProfile({required UserModel user}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.patch,
      url: '${EndPoints.updateUser}/${user.id!}',
      body: {
        'firstName': user.firstName,
        'lastName': user.lastName,
        'cpf': user.cpf,
        'cep': user.cep,
        'portfolioAbout': user.portfolioAbout,
        'portfolioTitle': user.portfolioTitle
      },
    );

    if (result['_id'] != null) {
      var userData = result as Map<String, dynamic>;
      UserModel data = UserModel.fromJson(userData);
      return SignUpResult.success(data);
    } else {
      return SignUpResult.error('Ocorreu um erro ao editar os dados. Tente novamente mais tarde!');
    }
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
      return ForgotPasswordResult.success("Um link de recuperação foi enviado para o seu e-mail");
    } else if (result['statusCode'] == 404) {
      return ForgotPasswordResult.error("E-mail não cadastrado!");
    }

    throw Exception('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
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
