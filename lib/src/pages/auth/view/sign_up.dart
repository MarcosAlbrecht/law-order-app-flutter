import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_datepicker.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:app_law_order/src/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final focus = FocusNode();
  final focusStatus = FocusNode();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneFormatter =
      MaskTextInputFormatter(mask: '(##) #####-####', filter: {
    '#': RegExp(r'[0-9]'),
  });
  final cepFormatter = MaskTextInputFormatter(mask: '#####-###', filter: {
    '#': RegExp(r'[0-9]'),
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final format = DateFormat("dd/MM/yyyy");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro",
          style: TextStyle(color: CustomColors.black),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(10), // Define o raio para arredondamento
            color: CustomColors.white, // Cor de fundo do container
          ),
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Form(
                key: _formKey,
                child: GetBuilder<AuthController>(
                  builder: (authController) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            "assets/MARCA-DAGUA.png",
                            height: 50,
                          ),
                          const Divider(
                            height: 30,
                          ),
                          const CustomTextField(
                            icon: Icons.person_2_outlined,
                            label: "Primeiro Nome",
                            validator: nameValidator,
                          ),
                          const CustomTextField(
                            icon: Icons.person,
                            label: "Segundo Nome",
                            validator: nameValidator,
                          ),
                          CustomDatePicker(
                            dateFormart: format,
                            label: 'Data de Nascimento',
                            onSaved: (data) {},
                          ),
                          CustomTextField(
                            icon: Icons.phone_android_outlined,
                            label: "Telefone",
                            validator: phoneValidator,
                            textInputType: TextInputType.phone,
                            inputFormatters: [phoneFormatter],
                          ),
                          const CustomTextField(
                            icon: Icons.email_outlined,
                            label: "E-mail",
                            validator: emailValidator,
                            textInputType: TextInputType.emailAddress,
                          ),
                          CustomTextField(
                            icon: Icons.email_outlined,
                            label: "cep",
                            textInputType: TextInputType.number,
                            inputFormatters: [cepFormatter],
                          ),
                          Visibility(
                            visible: authController.isWork.value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 2, bottom: 10),
                              child: DropdownButtonFormField(
                                items: const [
                                  DropdownMenuItem(
                                    child: Text("Opcao 1"),
                                  )
                                ],
                                onChanged: (data) {},
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: CustomColors.blueColor,
                                    ), // Defina a cor desejada da borda
                                  ),
                                  prefixIcon: const Icon(Icons.work_outline),
                                  labelText: "Área de Atuação",
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const CustomTextField(
                            icon: Icons.lock_clock_outlined,
                            label: "Senha",
                            textInputType: TextInputType.text,
                            isSecret: true,
                            validator: passwordValidator,
                          ),
                          const CustomTextField(
                            icon: Icons.lock_clock_outlined,
                            label: "Confirmar Senha",
                            textInputType: TextInputType.text,
                            isSecret: true,
                            validator: passwordValidator,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            child: Center(
                              child: Text(
                                  "Ao criar uma conta, concordo com os Termos de Uso e Política de Privacidade."),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
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
                                      color: CustomColors.white,
                                    )
                                  : Text(
                                      'Cadastre-se',
                                      style: TextStyle(
                                        color: CustomColors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}
