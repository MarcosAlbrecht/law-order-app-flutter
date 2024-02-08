import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDialog extends StatelessWidget {
  //final HomeController controller;

  const FilterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return AlertDialog(
          backgroundColor: CustomColors.white,
          title: const Text('Filtros'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Estado',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.states.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        visualDensity: VisualDensity.compact,
                        title: Text(controller.states[index]),
                        value: controller.stateSelected == controller.states[index],
                        onChanged: (value) {
                          controller.toggleStateItem(index);
                        },
                      );
                    },
                  ),
                ),
                const Divider(
                  height: 20,
                ),
                const Text(
                  'Cidade',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cities.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        visualDensity: VisualDensity.compact,
                        title: Text(controller.cities[index]),
                        value: controller.citySected == controller.cities[index],
                        onChanged: (value) {
                          controller.toggleCityItem(index);
                        },
                      );
                    },
                  ),
                ),
                const Divider(
                  height: 20,
                ),
                const Text(
                  'Área de atuação',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.occupationsAreas.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        visualDensity: VisualDensity.compact,
                        title: Text(controller.occupationsAreas[index].area!),
                        value: controller.occupationAreaSelected == controller.occupationsAreas[index].area!,
                        onChanged: (value) {
                          controller.toggleOccupationAreaItem(index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.cleanFilters();
                Get.back(result: false); // Fechar o diálogo
              },
              child: const Text('Limpar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.blueDark2Color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                controller.applyFilters();
                Get.back(result: true);
              },
              child: Text(
                'Filtrar',
                style: TextStyle(
                  color: CustomColors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
