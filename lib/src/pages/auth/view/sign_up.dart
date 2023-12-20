import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/occupation_areas_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_datepicker.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:app_law_order/src/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final focus = FocusNode();
  final focusStatus = FocusNode();
  final utilServices = UtilServices();
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
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
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
                          "assets/MARCA-DAGUA-NEGATIVA.png",
                          height: 50,
                        ),
                        const Divider(
                          height: 30,
                        ),
                        CustomTextField(
                          icon: Icons.person_2_outlined,
                          label: "Primeiro Nome",
                          validator: nameValidator,
                          onSaved: (value) {
                            authController.user.firstName = value;
                          },
                        ),
                        CustomTextField(
                          icon: Icons.person,
                          label: "Segundo Nome",
                          validator: nameValidator,
                          onSaved: (value) {
                            authController.user.lastName = value;
                          },
                        ),
                        CustomDatePicker(
                          dateFormart: format,
                          label: 'Data de Nascimento',
                          onSaved: (value) {
                            authController.user.birthday = value.toString();
                          },
                          validator: nascimentoValidator,
                        ),
                        CustomTextField(
                          icon: Icons.phone_android_outlined,
                          label: "Telefone",
                          validator: phoneValidator,
                          textInputType: TextInputType.phone,
                          inputFormatters: [phoneFormatter],
                          onSaved: (value) {
                            authController.user.phone = value;
                          },
                        ),
                        CustomTextField(
                          icon: Icons.email_outlined,
                          label: "E-mail",
                          validator: emailValidator,
                          textInputType: TextInputType.emailAddress,
                          onSaved: (value) {
                            authController.user.email = value;
                          },
                        ),
                        CustomTextField(
                          icon: Icons.email_outlined,
                          label: "cep",
                          textInputType: TextInputType.number,
                          inputFormatters: [cepFormatter],
                          validator: cepValidator,
                          onChanged: (value) async {
                            if (value != null && value.length == 9) {
                              await authController.handleValidateCep(
                                  cep1: value);
                            }
                          },
                          onSaved: (value) {
                            authController.user.cep = value;
                          },
                        ),
                        Visibility(
                          visible: authController.isWork.value,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 10),
                            child: DropdownButtonFormField(
                              items:
                                  authController.occupationsAreas.map((area) {
                                return DropdownMenuItem<OccupationAreasModel>(
                                  value: area,
                                  child: Text(
                                    area.area!,
                                  ), // Use o nome da área como rótulo
                                );
                              }).toList(),
                              onChanged: (data) {
                                authController.user.occupationArea = data?.area;
                              },
                              onSaved: (data) {
                                authController.user.occupationArea = data?.area;
                              },
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
                        CustomTextField(
                          icon: Icons.lock_clock_outlined,
                          label: "Senha",
                          textInputType: TextInputType.text,
                          isSecret: true,
                          validator: passwordValidator,
                          onSaved: (value) {
                            authController.user.password = value;
                          },
                        ),
                        CustomTextField(
                          icon: Icons.lock_clock_outlined,
                          label: "Confirmar Senha",
                          textInputType: TextInputType.text,
                          isSecret: true,
                          validator: passwordValidator,
                          onSaved: (value) {
                            authController.confirmPassword = value;
                          },
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
                              backgroundColor: CustomColors.blueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: authController.isLoading.value
                                ? null
                                : () async {
                                    //Get.toNamed(PagesRoutes.signUpStep1);
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      await authController.handleSignUp();
                                    } else {
                                      utilServices.showToast(
                                          message:
                                              "Verifique todos os campos!");
                                    }
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
