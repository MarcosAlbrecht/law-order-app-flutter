// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';

class ServicesTile extends StatelessWidget {
  final ServiceModel service;
  ServicesTile({
    Key? key,
    required this.service,
  }) : super(key: key);

  final UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * .85,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, right: 8),
        child: Material(
          elevation: 3,
          color: CustomColors.cyanColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: ListTile(
            visualDensity: VisualDensity.standard,
            dense: false,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                service.title!,
                style: TextStyle(fontSize: CustomFontSizes.fontSize14),
              ),
            ),
            subtitle: Text(
              service.description!,
              style: TextStyle(fontSize: CustomFontSizes.fontSize12),
            ),
            trailing: Text(
              utilServices.priceToCurrency(service.value!),
              style: TextStyle(fontSize: CustomFontSizes.fontSize14, color: CustomColors.blueDark2Color),
            ),
          ),
        ),
      ),
    );
  }
}
