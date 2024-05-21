import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelConfirmationDialog extends StatelessWidget {
  const CancelConfirmationDialog({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titulo
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Cancelamento de Solicitação',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: CustomFontSizes.fontSize16,
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
                    'Ao clicar no botão de cancelamento, a solicitação de serviço será imediatamente cancelada.',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),

                // Confirmar
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
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
                        Get.back(result: true);
                      },
                      child: Text(
                        'Sim',
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
