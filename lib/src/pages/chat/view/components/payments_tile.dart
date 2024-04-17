// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/fast_payment_model.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';

class PaymentsTile extends StatelessWidget {
  final FastPaymentModel payment;
  PaymentsTile({
    Key? key,
    required this.payment,
  }) : super(key: key);

  final utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Valor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: CustomFontSizes.fontSize14,
                ),
              ),
              Text(
                utilServices.priceToCurrency(payment.payment!.value!),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  backgroundColor: CustomColors.blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.visibility,
                      size: 18,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: CustomColors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  backgroundColor: CustomColors.blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    const Icon(
                      Icons.lock,
                      size: 18,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: CustomColors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
