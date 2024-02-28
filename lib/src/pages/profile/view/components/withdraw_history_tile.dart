// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/withdraw_history_model.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';

class WithdrawHistoryTile extends StatelessWidget {
  final WithdrawHistoryModel withdraw;
  //final RecommendationModel recommendation;
  final utilServices = UtilServices();

  WithdrawHistoryTile({
    Key? key,
    required this.withdraw,
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
                      const Text(
                        'Data Solicitação: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        utilServices.formatDate(
                          withdraw.createdAt!,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  const Divider(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Valor: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(utilServices.priceToCurrency(withdraw.value ?? 0)),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  const Divider(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Status: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildStatusText(withdraw.status!),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  const Divider(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Data final: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        withdraw.updatedAt != null ? utilServices.formatDate(withdraw.updatedAt) : '',
                      ),
                      const SizedBox(
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

  Widget _buildStatusText(String status) {
    String translatedText;
    Color textColor;

    switch (status) {
      case 'PENDING':
        translatedText = 'Pendente';
        textColor = Colors.orange;
        break;
      case 'APPROVED':
        translatedText = 'Aprovado';
        textColor = CustomColors.green;
        break;
      case 'REJECTED':
        translatedText = 'Rejeitado';
        textColor = Colors.red;
        break;
      default:
        translatedText = 'Desconhecido';
        textColor = Colors.black;
        break;
    }

    return Text(
      translatedText,
      style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
    );
  }
}
