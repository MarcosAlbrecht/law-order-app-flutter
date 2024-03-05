import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/service_model.dart';
import 'package:flutter/material.dart';

class ServiceDialog extends StatelessWidget {
  final ServiceModel service;

  const ServiceDialog({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        service.title ?? '',
        style: TextStyle(fontSize: CustomFontSizes.fontSize16),
      ),
      content: Text(service.description ?? ''),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.blueDark2Color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Fechar',
            style: TextStyle(color: CustomColors.white),
          ),
        )
      ],
    );
  }
}
