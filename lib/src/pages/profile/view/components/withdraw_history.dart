// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';

class AvaliationsTile extends StatelessWidget {
  //final RecommendationModel recommendation;
  final utilServices = UtilServices();

  AvaliationsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Text('Data Solicitação: '),
                      Text(utilServices.formatDateTime(DateTime.now().toString())),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Text('Valor: '),
                      Text(utilServices.priceToCurrency(200)),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Text('Status: '),
                      Text('Aguardando'),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Text('Data Final: '),
                      Text(utilServices.formatDateTime(DateTime.now().toString())),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          child: Container(
            color: CustomColors.blueDark2Color,
            width: 5,
          ),
        )
      ],
    );
  }
}
