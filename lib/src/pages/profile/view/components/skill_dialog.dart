// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/profile/controller/profile_controller.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:app_law_order/src/services/validators.dart';

class SkillDialog extends StatefulWidget {
  const SkillDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<SkillDialog> createState() => _SkillDialogState();
}

class _SkillDialogState extends State<SkillDialog> {
  final focus = FocusNode();
  final focusStatus = FocusNode();
  final utilServices = UtilServices();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GetBuilder<ProfileController>(
              builder: (controller) {
                return SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Titulo
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Adicionar Competência',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        // Campo de email
                        CustomTextField(
                          validator: skillValidator,
                          label: 'Competência',
                          textInputType: TextInputType.text,
                          onSaved: (value) {
                            controller.skill = value!;
                          },
                        ),

                        // Confirmar
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.blueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            //Get.toNamed(PagesRoutes.signUpStep1);
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              await controller.handleSkill(status: "insert");
                              Navigator.of(context).pop();
                            } else {
                              utilServices.showToast(
                                  message: "Verifique os campos!");
                            }
                          },
                          child: controller.isSavingSkill
                              ? CircularProgressIndicator(
                                  color: CustomColors.white,
                                )
                              : Text(
                                  'Salvar',
                                  style: TextStyle(
                                    color: CustomColors.white,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Botão para fechar
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
