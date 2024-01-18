// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';

import 'package:app_law_order/src/models/service_model.dart';

class ServicesTile extends StatelessWidget {
  final ServiceModel service;

  ServicesTile({
    Key? key,
    required this.service,
  }) : super(key: key);

  final utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${service.title!}',
      ),
      trailing: Text(
        utilServices.priceToCurrency(
          service.value!,
        ),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CustomColors.blueDark2Color,
            fontSize: CustomFontSizes.fontSize14),
      ),
    );
  }
}
