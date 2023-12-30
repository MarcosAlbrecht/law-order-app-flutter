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

  final UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.backgroudCard,
      ),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        title: Text(
          service.title!,
          style: TextStyle(fontSize: CustomFontSizes.fontSize16),
        ),
        subtitle: Text(
          service.description!,
          style: TextStyle(fontSize: CustomFontSizes.fontSize12),
        ),
        trailing: Text(
          utilServices.priceToCurrency(service.value!),
          style: TextStyle(fontSize: CustomFontSizes.fontSize14),
        ),
      ),
    );
  }
}
