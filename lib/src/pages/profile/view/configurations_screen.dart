import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/profile/controller/configurations_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigurationsScreen extends StatefulWidget {
  const ConfigurationsScreen({super.key});

  @override
  State<ConfigurationsScreen> createState() => _ConfigurationsScreenState();
}

class _ConfigurationsScreenState extends State<ConfigurationsScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configurações",
          style: TextStyle(color: CustomColors.black),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: CustomColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: GetBuilder<ConfigurationsController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Row para o texto e switch
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Alinha os elementos horizontalmente ao topo
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ajusta o espaçamento horizontal entre os elementos
                    children: [
                      Text(
                        'Ativar notificações push',
                        style: TextStyle(
                          fontSize: CustomFontSizes.fontSize14,
                        ),
                      ),
                      Switch(
                        value: controller.authController.user.tokenOneSignal == null ||
                                controller.authController.user.tokenOneSignal!.isEmpty
                            ? false
                            : true,
                        onChanged: (value) {
                          controller.handleChangeTokenOneSignal();
                        },
                      )
                    ],
                  ),

                  //botao para salvar
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
