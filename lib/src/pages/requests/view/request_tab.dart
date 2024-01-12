import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/requests/controller/request_controller.dart';
import 'package:app_law_order/src/pages/requests/view/components/request_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestTab extends StatelessWidget {
  const RequestTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: Container(
          padding: const EdgeInsets.all(16),
          height: size.height,
          width: size.width,
          child: GetBuilder<RequestController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //container com os botoes para selecionar solicitaçoes enviadas ou recebidas
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.selectCategory(value: 'received');
                          },
                          child: Container(
                            height: 80,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: controller.currentCategory == "received"
                                  ? CustomColors.blueDark2Color
                                  : CustomColors.backGround,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Solicitações',
                                  style: TextStyle(
                                    fontSize: CustomFontSizes.fontSize12,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Recebidas',
                                      style: TextStyle(
                                        fontSize: CustomFontSizes.fontSize20,
                                        fontWeight: FontWeight.bold,
                                        color: controller.currentCategory ==
                                                "received"
                                            ? CustomColors.white
                                            : CustomColors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 5,
                        color: Colors.transparent,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.selectCategory(value: 'sent');
                          },
                          child: Container(
                            height: 80,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: controller.currentCategory == "sent"
                                  ? CustomColors.blueDark2Color
                                  : CustomColors.backGround,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Solicitações',
                                  style: TextStyle(
                                    fontSize: CustomFontSizes.fontSize12,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Enviadas',
                                      style: TextStyle(
                                        fontSize: CustomFontSizes.fontSize20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            controller.currentCategory == "sent"
                                                ? CustomColors.white
                                                : CustomColors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          icon: Icons.search,
                          label: "Pesquisar",
                        ),
                      ),
                      Expanded(
                        child: DropdownMenu<String>(
                            requestFocusOnTap: true,
                            label: Text('Filtrar'),
                            dropdownMenuEntries: [
                              DropdownMenuEntry<String>(
                                  label: 'Filtrar', value: '1'),
                              DropdownMenuEntry<String>(
                                  label: 'Mais Antigas', value: '2'),
                              DropdownMenuEntry<String>(
                                  label: 'Mais Recentes', value: '3'),
                            ]),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        return RequestTile(
                          requestModel: controller.allRequest[index],
                        );
                      },
                      separatorBuilder: (_, index) => const SizedBox(
                        height: 5,
                      ),
                      itemCount: controller.allRequest.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
