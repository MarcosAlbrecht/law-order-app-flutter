import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:app_law_order/src/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      backgroundColor: CustomColors.blueColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Nome do APP
                    // SvgPicture.asset(
                    //   'assets/logo3.svg',
                    //   colorBlendMode: BlendMode.srcIn,
                    //   fit: BoxFit.contain,
                    //   width: 200,
                    // ),
                    // Image.asset(
                    //   "assets/logo/MARCA-DAGUA-PRETA-2.png",
                    // )
                    //Categorias
                  ],
                ),
              ),
              //Formulario
              Container(
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32,
                  bottom: 20,
                  top: 40,
                ),
                decoration: BoxDecoration(
                    color: CustomColors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(45),
                    )),
                //Campos de email e senha
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        String email = emailController.text;
                                        String password =
                                            passwordController.text;
                                        // authController.signIn(
                                        //   email: email,
                                        //   password: password,
                                        // );
                                      } else {
                                        //print('Campos não válidos');
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? CircularProgressIndicator(
                                      color: CustomColors.black,
                                    )
                                  : Text(
                                      'Entrar',
                                      style: TextStyle(
                                        color: CustomColors.black,
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
                            style: TextStyle(color: CustomColors.black),
                          ),
                          onPressed: () async {
                            // final bool? result = await showDialog(
                            //   context: context,
                            //   builder: (_) {
                            //     return ForgotPasswordDialog(
                            //         email: emailController.text);
                            //   },
                            // );

                            // if (result ?? false) {
                            //   // utilServices.showToast(
                            //   //     message:
                            //   //         'Um link de recuperação foi enviado para o seu meail');
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
                                backgroundColor: CustomColors.blueColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        String email = emailController.text;
                                        String password =
                                            passwordController.text;
                                        // authController.signIn(
                                        //   email: email,
                                        //   password: password,
                                        // );
                                      } else {
                                        //print('Campos não válidos');
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? CircularProgressIndicator(
                                      color: CustomColors.black,
                                    )
                                  : Text(
                                      'Cadastre-se',
                                      style: TextStyle(
                                        color: CustomColors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
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
}
