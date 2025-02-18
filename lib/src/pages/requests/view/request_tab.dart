import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/requests/controller/request_controller.dart';
import 'package:app_law_order/src/pages/requests/view/components/request_tile.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RequestTab extends StatefulWidget {
  const RequestTab({Key? key}) : super(key: key);

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
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
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: CustomColors.black.withOpacity(0.2),
                                  blurRadius: 4, // Ajuste conforme necessário
                                  offset: const Offset(3, 4), // Ajuste conforme necessário
                                ),
                              ],
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
                                    color: controller.currentCategory == "received" ? CustomColors.white : CustomColors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Recebidas',
                                      style: TextStyle(
                                        fontSize: CustomFontSizes.fontSize20,
                                        fontWeight: FontWeight.bold,
                                        color: controller.currentCategory == "received" ? CustomColors.white : CustomColors.black,
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
                        width: 10,
                        color: Colors.transparent,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.selectCategory(value: 'sent');
                          },
                          child: Container(
                            height: 80,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: CustomColors.black.withOpacity(0.2),
                                  blurRadius: 4, // Ajuste conforme necessário
                                  offset: const Offset(3, 4), // Ajuste conforme necessário
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: controller.currentCategory == "sent" ? CustomColors.blueDark2Color : CustomColors.backGround,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Solicitações',
                                  style: TextStyle(
                                    fontSize: CustomFontSizes.fontSize12,
                                    fontWeight: FontWeight.bold,
                                    color: controller.currentCategory == "sent" ? CustomColors.white : CustomColors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Enviadas',
                                      style: TextStyle(
                                        fontSize: CustomFontSizes.fontSize20,
                                        fontWeight: FontWeight.bold,
                                        color: controller.currentCategory == "sent" ? CustomColors.white : CustomColors.black,
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
                  //container com o botao de pesquisa
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            icon: Icons.search,
                            label: "Pesquisar",
                            onChanged: (value) {
                              controller.searchRequest.value = value!.toLowerCase();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 5),
                          child: SizedBox(
                            width: 70,
                            height: double.infinity,
                            child: Material(
                              elevation: 3,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: PopupMenuButton<String>(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0), // Borda arredondada
                                ),
                                icon: const Icon(FontAwesome.sliders),
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: '1',
                                    child: const Text('Filtrar'),
                                    onTap: () {
                                      controller.handleSort(value: "DESC");
                                    },
                                  ),
                                  PopupMenuItem<String>(
                                    value: '2',
                                    child: const Text('Mais antigas'),
                                    onTap: () {
                                      controller.handleSort(value: "ASC");
                                    },
                                  ),
                                  PopupMenuItem<String>(
                                    value: '3',
                                    child: const Text('Mais recentes'),
                                    onTap: () {
                                      controller.handleSort(value: "DESC");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.allRequest.isNotEmpty,
                    replacement: Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              color: CustomColors.blueDarkColor,
                            ),
                            const Text('Não há solicitações para apresentar'),
                          ],
                        ),
                      ),
                    ),
                    child: Expanded(
                      child: Visibility(
                        visible: !controller.isLoading,
                        replacement: Center(
                          child: LoadingAnimationWidget.discreteCircle(
                            color: CustomColors.blueDark2Color,
                            secondRingColor: CustomColors.blueDarkColor,
                            thirdRingColor: CustomColors.blueColor,
                            size: 50,
                          ),
                        ),
                        child: ListView.separated(
                          itemBuilder: (_, index) {
                            if (((index + 1) == controller.allRequest.length) && (!controller.isLastPage)) {
                              controller.loadMoreRequestsReceived();
                            }
                            return RequestTile(
                              currentCategory: controller.currentCategory,
                              requestModel: controller.allRequest[index],
                            );
                          },
                          separatorBuilder: (_, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: controller.allRequest.length,
                        ),
                      ),
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
