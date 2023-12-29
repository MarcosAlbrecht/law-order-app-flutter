import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/profile/controller/profile_controller.dart';
import 'package:app_law_order/src/pages/profile/view/components/camera_dialog.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:app_law_order/src/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final focus = FocusNode();
  final focusStatus = FocusNode();
  final utilServices = UtilServices();
  final _formKey = GlobalKey<FormState>();

  final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  final cepFormatter = MaskTextInputFormatter(
    mask: '########',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informações Pessoais",
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
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: CustomColors.white,
          ),
          child: GetBuilder<ProfileController>(
            builder: (controller) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 30,
                        bottom: 10,
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: CustomColors.blueColor,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: controller.authController.user
                                              .profilePicture !=
                                          null
                                      ? Image.network(
                                          controller.authController.user
                                              .profilePicture!.url!,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              // Exibir um ícone de carregamento enquanto a imagem está sendo carregada
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: CustomColors
                                                      .blueDark2Color,
                                                ),
                                              );
                                            }
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return const Icon(Icons.error);
                                          },
                                          height: 160,
                                          width: 160,
                                          fit: BoxFit.cover,
                                        )
                                      : controller.imageBytes.isEmpty
                                          ? Image.asset(
                                              "assets/ICONPEOPLE.png",
                                              height: 160,
                                              width: 160,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.memory(
                                              controller.imageBytes,
                                              height: 160,
                                              width: 160,
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) {
                                          return CameraDialog(
                                            isPortfolio: false,
                                          );
                                        });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: CustomColors.blueDark2Color,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.mode_edit_outline_rounded,
                                      color: CustomColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    icon: Icons.person_2_outlined,
                                    label: "Primeiro Nome",
                                    textInputType: TextInputType.name,
                                    validator: nameValidator,
                                    initialValue: controller
                                        .authController.user.firstName,
                                    onSaved: (value) {
                                      controller.authController.user.firstName =
                                          value;
                                    },
                                  ),
                                  CustomTextField(
                                    icon: Icons.person_2_outlined,
                                    label: "Último Nome",
                                    textInputType: TextInputType.name,
                                    validator: nameValidator,
                                    initialValue:
                                        controller.authController.user.lastName,
                                    onSaved: (value) {
                                      controller.authController.user.lastName =
                                          value;
                                    },
                                  ),
                                  CustomTextField(
                                    icon: Icons.person_pin_outlined,
                                    label: "CPF",
                                    textInputType: TextInputType.number,
                                    inputFormatters: [cpfFormatter],
                                    validator: cpfValidator,
                                    initialValue:
                                        controller.authController.user.cpf,
                                    onSaved: (value) {
                                      controller.authController.user.cpf =
                                          value;
                                    },
                                  ),
                                  CustomTextField(
                                    icon: Icons.phone_android_outlined,
                                    label: "Telefone",
                                    validator: phoneValidator,
                                    textInputType: TextInputType.phone,
                                    inputFormatters: [phoneFormatter],
                                    initialValue:
                                        controller.authController.user.phone,
                                    onSaved: (value) {
                                      controller.authController.user.phone =
                                          value;
                                    },
                                  ),
                                  CustomTextField(
                                    icon: Icons.email_outlined,
                                    label: "CEP",
                                    textInputType: TextInputType.number,
                                    inputFormatters: [cepFormatter],
                                    validator: cepValidator,
                                    initialValue:
                                        controller.authController.user.cep,
                                    onChanged: (value) async {
                                      if (value != null && value.length == 8) {
                                        await controller.authController
                                            .handleValidateCep(cep1: value);
                                      }
                                    },
                                    onSaved: (value) {
                                      controller.authController.user.cep =
                                          value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: CustomColors.blueColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: controller
                                              .authController.isLoading.value
                                          ? null
                                          : () async {
                                              //Get.toNamed(PagesRoutes.signUpStep1);
                                              FocusScope.of(context).unfocus();
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();
                                                await controller
                                                    .handleUpdateProfile();
                                              } else {
                                                utilServices.showToast(
                                                    message:
                                                        "Verifique todos os campos!");
                                              }
                                            },
                                      child: controller.isSaving
                                          ? CircularProgressIndicator(
                                              color: CustomColors.white,
                                            )
                                          : Text(
                                              'Atualizar perfil',
                                              style: TextStyle(
                                                color: CustomColors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
