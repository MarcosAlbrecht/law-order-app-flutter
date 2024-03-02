// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/recommendation_model.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';

class AvaliationsTile extends StatelessWidget {
  final RecommendationModel recommendation;
  final utilServices = UtilServices();

  AvaliationsTile({
    Key? key,
    required this.recommendation,
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
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${recommendation.whoRecommended!.firstName ?? 'Usuário'} ${recommendation.whoRecommended!.lastName ?? 'removido'} ',
                      style: TextStyle(
                        color: CustomColors.blueDark2Color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(recommendation.whoRecommended!.city ?? ''),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Text('Geral: '),
                      Text(recommendation.rating.toString()),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.star,
                        color: Color(0XFFf59e0b),
                        size: 12,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(utilServices.formatDate(recommendation.createdAt)),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Text('Satisfação: '),
                      Text(recommendation.levelOfSatisfaction!.toDouble().toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Text('Pontualidade: '),
                      Text(recommendation.providerPunctuality!.toDouble().toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Text('Qualidade: '),
                      Text(recommendation.serviceQuality!.toDouble().toString()),
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
