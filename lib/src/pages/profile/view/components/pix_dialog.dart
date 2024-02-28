import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/profile/controller/withdraw_controller.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class PixDialog extends StatefulWidget {
  PixDialog({super.key});

  @override
  State<PixDialog> createState() => _PixDialogState();
}

final chavePixEC = TextEditingController();

final utilServices = UtilServices();

cleanText() {
  chavePixEC.clear();
}

class _PixDialogState extends State<PixDialog> {
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
            child: GetBuilder<WithDrawController>(
              builder: (controller) {
                return SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Titulo
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Cadastro de chave PIX',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        // Descrição
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            'Nova chave',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Campo de email
                        CustomTextField(
                          contentPadding: false,
                          //initialValue: controller.actualService.title,
                          //validator: titleServiceValidator,
                          label: 'Pix',
                          textInputType: TextInputType.text,
                          controller: chavePixEC,
                          onChanged: (value) {
                            //controller.actualService.title = value;
                            chavePixEC.text = value!;
                          },
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.blueDark2Color,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (chavePixEC.text == null) {
                                utilServices.showToast(message: 'Preencha o campo para continuar');
                              } else {
                                controller.handleCreatePix(key: chavePixEC.text);
                                cleanText();
                              }
                              //Get.back(result: true);
                            },
                            child: Text(
                              'Gravar',
                              style: TextStyle(
                                color: CustomColors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        const Divider(
                          height: 20,
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Chaves Cadastradas',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 0),
                          child: Text(
                            'Selecione a chave que deseja receber os pagamentos',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: controller.user.pix?.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: CheckboxListTile(
                                      visualDensity: VisualDensity.compact,
                                      title: Text(
                                        controller.user.pix![index].key!,
                                        style: TextStyle(
                                            color: CustomColors.blueDark2Color,
                                            fontWeight: FontWeight.bold,
                                            fontSize: CustomFontSizes.fontSize14),
                                      ),
                                      value: controller.user.pix![index].active,
                                      activeColor: CustomColors.blueDark2Color,
                                      onChanged: (value) {
                                        controller.toggleStateItem(index: index);
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      FontAwesome.trash_empty,
                                    ),
                                    onPressed: () {
                                      // Adicione a lógica para excluir o item aqui
                                      controller.handleDeletePix(index: index);
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.handleShowClosePixDialog('canceled');
                                Get.back(result: false); // Fechar o diálogo
                              },
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.blueDark2Color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                controller.handleUpdatePix();
                                Get.back(result: true);
                              },
                              child: Text(
                                'Salvar',
                                style: TextStyle(
                                  color: CustomColors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
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
