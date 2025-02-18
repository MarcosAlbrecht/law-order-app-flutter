import 'dart:io';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/auth/view/components/forgot_password_dialog.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:app_law_order/src/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  final utilServices = UtilServices();

  //controlador de campos
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Formulario
              Container(
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32,
                  bottom: 20,
                  top: 15,
                ),
                decoration: BoxDecoration(
                  color: CustomColors.white,
                ),
                //Campos de email e senha
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "assets/SIMBOLO-2.png",
                        height: 100,
                        width: 100,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Divider(
                          height: 40,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: CustomFontSizes.fontSize24,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        color: Colors.transparent,
                      ),
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'Email',
                        textInputType: TextInputType.emailAddress,
                        validator: emailValidator,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        //validator: passwordValidator,
                      ),

                      //Botao de login
                      SizedBox(
                        height: 50,
                        child: GetBuilder<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.blueColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        String email = emailController.text;
                                        String password = passwordController.text;
                                        authController.signIn(
                                          email: email,
                                          password: password,
                                        );
                                      } else {
                                        //print('Campos não válidos');
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? CircularProgressIndicator(
                                      color: CustomColors.blueDark2Color,
                                    )
                                  : Text(
                                      'Login',
                                      style: TextStyle(
                                        color: CustomColors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                      //Botao esqueceu senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(color: CustomColors.blueColor, fontSize: CustomFontSizes.fontSize16),
                          ),
                          onPressed: () async {
                            final bool? result = await showDialog(
                              context: context,
                              builder: (_) {
                                return ForgotPasswordDialog(email: emailController.text);
                              },
                            );

                            // if (result ?? false) {
                            //   utilServices.showToast(
                            //       message:
                            //           'Um link de recuperação foi enviado para o seu e-mail');
                            // }
                          },
                        ),
                      ),

                      //Divisor login e criar conta
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: GetBuilder<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.blueDarkColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      Get.toNamed(PagesRoutes.signUpStep1);
                                    },
                              child: authController.isLoading.value
                                  ? CircularProgressIndicator(
                                      color: CustomColors.blueDark2Color,
                                    )
                                  : Text(
                                      'Cadastre-se',
                                      style: TextStyle(
                                        color: CustomColors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      //box que contem o botão com o login do google
                      SizedBox(
                        height: 50,
                        child: GetBuilder<AuthController>(
                          builder: (authController) {
                            return buildLoginButton(authController);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Platform.isIOS
                          ? SizedBox(
                              height: 50,
                              child: GetBuilder<AuthController>(
                                builder: (authController) {
                                  return SignInWithAppleButton(
                                    text: 'Continuar com a Apple',
                                    onPressed: () {
                                      authController.loginApple();
                                    },
                                  );
                                },
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildLoginButton(AuthController authController) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: CustomColors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: authController.isLoading.value
          ? null
          : () {
              authController.loginGoogle();
            },
      icon: !authController.isLoading.value
          ? Image.asset(
              'assets/google_logo_icon.png',
              scale: 2,
            )
          : const SizedBox.shrink(),
      label: authController.isLoading.value
          ? CircularProgressIndicator(
              color: CustomColors.blueDark2Color,
            )
          : Text(
              'Continuar com o Google',
              style: TextStyle(
                color: CustomColors.black,
                fontSize: CustomFontSizes.fontSize14,
              ),
            ),
    );
  }
}
