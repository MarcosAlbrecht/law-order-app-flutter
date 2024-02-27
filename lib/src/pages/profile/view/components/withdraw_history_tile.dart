// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';

class WithdrawHistoryTile extends StatelessWidget {
  //final RecommendationModel recommendation;
  final utilServices = UtilServices();

  WithdrawHistoryTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text('Data Solicitação: '),
                      Text(''),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Divider(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Valor: '),
                      Text(''),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Divider(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Status: '),
                      Text(''),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Divider(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Data final: '),
                      Text(''),
                      SizedBox(
                        width: 5,
                      ),
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
