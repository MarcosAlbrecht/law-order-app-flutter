// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/requests/controller/request_controller.dart';

class ContestDialog extends StatelessWidget {
  final RequestModel request;
  final String selectedCategory;
  const ContestDialog({
    Key? key,
    required this.request,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Atenção',
        style: TextStyle(fontSize: CustomFontSizes.fontSize16),
      ),
      content: GetBuilder<RequestController>(
        builder: (controller) {
          late String name = '';
          if (selectedCategory == Constants.received) {
            name =
                '${request.requester?.firstName!.trim()} ${request.requester?.lastName?.trim()}';
          } else {
            name =
                '${request.requested?.firstName!.trim()} ${request.requester?.lastName?.trim()}';
          }
          return Text(
              'Ao clicar no botão "Quero prosseguir", você estará iniciando um processo formal de resolução de problemas com o usuário $name, com quem você está atualmente envolvido em um serviço.Este recurso foi desenvolvido para resolver possíveis divergências de forma justa e eficaz.A partir do momento em que a disputa é aberta, o pagamento relacionado ao serviço em questão será temporariamente bloqueado. Isso significa que nenhum dos envolvidos terá acesso aos fundos até que uma decisão seja alcançada.Durante esse período, nossa equipe estará monitorando de perto o andamento da disputa. Ressaltamos que a Prestadio poderá intervir no processo, se necessário, para garantir uma avaliação imparcial e justa. Nosso objetivo é assegurar que ambas as partes envolvidas sejam ouvidas e que uma resolução equitativa seja alcançada.');
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fechar o diálogo
          },
          child: const Text('Cancelar'),
        ),
        GetBuilder<RequestController>(
          builder: (controller) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.blueDark2Color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                controller.openContest(request: request);
                Navigator.of(context).pop();
              },
              child: Text(
                'Quero prosseguir',
                style: TextStyle(color: CustomColors.white),
              ),
            );
          },
        ),
      ],
    );
  }
}
