import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/profile_view/controller/service_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceRequestScreen extends StatelessWidget {
  const ServiceRequestScreen({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: CustomColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Expanded(
                  child: Text(
                      'Selecione o(s) serviço(s) desejado(s) e clique em "Enviar solicitação"'),
                ),
              ),
              SizedBox(
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
                              'Solicitar serviço',
                              style: TextStyle(
                                color: CustomColors.white,
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
    );
  }
}
