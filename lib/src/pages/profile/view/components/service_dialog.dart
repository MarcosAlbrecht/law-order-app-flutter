// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/profile/controller/profile_controller.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:app_law_order/src/services/validators.dart';

class ServiceDialog extends StatefulWidget {
  final String status;
  const ServiceDialog({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  State<ServiceDialog> createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<ServiceDialog> {
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
                            'Adicionar Serviço',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        // Descrição
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 20,
                          ),
                          child: Text(
                            'Preencha as informações do serviço que você deseja cadastrar. Lembre-se de informar com clareza os detalhes 😁',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                        ),

                        // Campo de email
                        CustomTextField(
                          initialValue: controller.actualService.title,
                          validator: titleServiceValidator,
                          label: 'Serviço',
                          textInputType: TextInputType.text,
                          onSaved: (value) {
                            controller.actualService.title = value;
                          },
                        ),
                        CustomTextField(
                          initialValue: controller.actualService.description,
                          validator: descriprionServiceValidator,
                          label: 'Descrição',
                          minLines: 1,
                          maxLines: 3,
                          textInputType: TextInputType.text,
                          onSaved: (value) {
                            controller.actualService.description = value;
                          },
                        ),
                        CustomTextField(
                          initialValue: controller.actualService.value != null
                              ? controller.actualService.value.toString()
                              : '',
                          label: 'Valor',
                          validator: valueServiceValidator,
                          textInputType: TextInputType.number,
                          onSaved: (value) {
                            controller.actualService.value =
                                double.parse(value!);
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
                              await controller.handleService(
                                  status: widget.status);
                              Navigator.of(context).pop();
                            } else {
                              utilServices.showToast(
                                  message: "Verifique todos os campos!");
                            }
                          },
                          child: controller.isSaving
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
