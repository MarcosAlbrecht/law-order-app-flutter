// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/profile_view/controller/profile_view_controller.dart';
import 'package:app_law_order/src/pages/profile_view/controller/service_request_controller.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';

import 'package:app_law_order/src/models/service_model.dart';
import 'package:get/get.dart';

class ServicesRequestTile extends StatelessWidget {
  final ServiceModel service;
  ServicesRequestTile({
    Key? key,
    required this.service,
  }) : super(key: key);

  final UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        //color: CustomColors.backgroudCard,
      ),
      child: GetBuilder<ServiceRequestController>(
        builder: (controller) {
          return ListTile(
            visualDensity: VisualDensity.comfortable,
            title: Text(
              service.title!,
              style: TextStyle(fontSize: CustomFontSizes.fontSize16),
            ),
            subtitle: Text(
              utilServices.priceToCurrency(service.value!),
              style: TextStyle(fontSize: CustomFontSizes.fontSize14),
            ),
            trailing: Checkbox.adaptive(
              value: controller.isChecked(service: service),
              onChanged: (value) async {
                await controller.handleCheckBox(
                    value: value!, service: service);
              },
            ),
          );
        },
      ),
    );
  }
}
