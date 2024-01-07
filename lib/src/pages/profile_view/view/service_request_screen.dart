import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/profile_view/controller/service_request_controller.dart';
import 'package:app_law_order/src/pages/profile_view/view/components/services_request_tile.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceRequestScreen extends StatelessWidget {
  ServiceRequestScreen({Key? key}) : super(key: key);

  final utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Solicitação de serviço",
          style: TextStyle(color: CustomColors.black),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //botao para solicitar o servico
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Selecione o(s) serviço(s) desejado(s) e clique em "Enviar solicitação"',
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: CustomFontSizes.fontSize14),
                    ),
                    GetBuilder<ServiceRequestController>(
                      builder: (controller) {
                        return Expanded(
                          child: Visibility(
                            visible: controller.services.isNotEmpty,
                            replacement: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    color: CustomColors.blueDarkColor,
                                  ),
                                  const Text('Não há itens para apresentar'),
                                ],
                              ),
                            ),
                            child: ListView.separated(
                                itemBuilder: (_, index) {
                                  return ServicesRequestTile(
                                    service: controller.services[index],
                                  );
                                },
                                separatorBuilder: (_, index) => const Divider(
                                      height: 10,
                                    ),
                                itemCount: controller.services.length),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Valor Total:',
                      style: TextStyle(
                          color: CustomColors.black,
                          fontSize: CustomFontSizes.fontSize18,
                          fontWeight: FontWeight.bold),
                    ),
                    GetBuilder<ServiceRequestController>(
                      builder: (controller) {
                        return Text(
                          utilServices
                              .priceToCurrency(controller.orderService.total!),
                          style: TextStyle(
                              color: CustomColors.black,
                              fontSize: CustomFontSizes.fontSize18,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ],
                ),
              ),

              //BOTAO PARA ENVIAR SOLICITAÇAO
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 50,
                  child: GetBuilder<ServiceRequestController>(
                    builder: (authController) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.blueDark2Color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: authController.isLoading
                            ? null
                            : () {
                                Get.back();
                              },
                        child: authController.isSaving
                            ? CircularProgressIndicator(
                                color: CustomColors.black,
                              )
                            : Text(
                                'Enviar solicitação',
                                style: TextStyle(
                                  color: CustomColors.white,
                                  fontSize: 18,
                                ),
                              ),
                      );
                    },
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
