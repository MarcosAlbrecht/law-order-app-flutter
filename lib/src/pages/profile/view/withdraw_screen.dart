import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/profile/controller/withdraw_controller.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawScreen extends StatefulWidget {
  WithdrawScreen({super.key});

  final utilServices = UtilServices();

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Requisições de Saque",
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
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Visibility(
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Aqui você pode visualizar e solicitar saques e difinir uma chave PIX para receber os pagamentos',
                      ),
                      const Divider(
                        height: 30,
                      ),
                      Text(
                        'Pix',
                        style: TextStyle(fontSize: CustomFontSizes.fontSize14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Chave pix para aonde serão enviados os saques',
                        style: TextStyle(fontSize: CustomFontSizes.fontSize12, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.pix,
                                color: Color(
                                  0XFF00bdaf,
                                ),
                                size: 40,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('chavepixaqui'),
                            ],
                          ),
                          GetBuilder<WithDrawController>(
                            builder: (controller) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  visualDensity: VisualDensity.compact,
                                  padding: const EdgeInsets.all(15),
                                  backgroundColor: CustomColors.blueDark2Color,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Alterar Pix',
                                  style: TextStyle(
                                    color: CustomColors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Divider(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Saldo disponível:',
                                    style: TextStyle(
                                        color: CustomColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: CustomFontSizes.fontSize16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    utilServices.priceToCurrency(150),
                                    style: TextStyle(
                                        color: CustomColors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: CustomFontSizes.fontSize20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Prazo de 7 dias para a conclusão do saque'),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Valor solicitado'),
                          Container(
                            height: 43,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: CustomTextField(
                                    contentPadding: false,
                                    paddingBottom: false,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GetBuilder<WithDrawController>(
                                  builder: (controller) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(vertical: 1),
                                      height: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          //visualDensity: VisualDensity.compact,
                                          //padding: const EdgeInsets.all(15),
                                          backgroundColor: CustomColors.blueDark2Color,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'Solicitar',
                                          style: TextStyle(
                                            color: CustomColors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
