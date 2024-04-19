// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/fast_payment_model.dart';
import 'package:app_law_order/src/pages/chat/controller/wallet_payments_controller.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/state_manager.dart';

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
          Expanded(
            child: Column(
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
                  style: TextStyle(
                    fontSize: CustomFontSizes.fontSize16,
                    color: CustomColors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<WalletPaymentsController>(
            builder: (controller) {
              return Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.visibility,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Visualizar',
                          style: const TextStyle(color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //showPopupTermsUse(context);
                              _launchURL(context, link: payment.payment!.link!);
                            },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  paymentStatus(controller, payment),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

Widget paymentStatus(WalletPaymentsController controller, FastPaymentModel payment) {
  final status = payment.payment!.status!;
  if (status == 'PAID') {
    return PaidButton(controller: controller, payment: payment);
  } else if (status == 'APPROVED') {
    return ApprovedButton(controller: controller);
  } else if (status == 'PENDING') {
    return PendingButton(controller: controller);
  } else {
    // Trate outros status se necessário, ou retorne um widget padrão
    return const SizedBox.shrink();
  }
}

class ApprovedButton extends StatelessWidget {
  final WalletPaymentsController controller;
  const ApprovedButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        backgroundColor: CustomColors.blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        controller.isLoading;
      },
      child: Row(
        children: [
          Icon(
            Typicons.lock_open,
            size: 16,
            color: CustomColors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Liberado',
            style: TextStyle(
              color: CustomColors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class PaidButton extends StatelessWidget {
  final WalletPaymentsController controller;
  final FastPaymentModel payment;
  const PaidButton({
    Key? key,
    required this.controller,
    required this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        backgroundColor: const Color(0xffffc107),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        controller.releasePayment(paymentId: payment.payment!.id!);
      },
      child: Row(
        children: [
          Icon(
            Elusive.ok_circled2,
            size: 16,
            color: CustomColors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Liberar',
            style: TextStyle(
              color: CustomColors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class PendingButton extends StatelessWidget {
  final WalletPaymentsController controller;
  PendingButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        backgroundColor: const Color(0xfff8c060),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        utilServices.showToast(message: 'Efetue o pagamento para fazer a liberação!');
      },
      child: Row(
        children: [
          Icon(
            ModernPictograms.clock,
            size: 16,
            color: CustomColors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Pendente',
            style: TextStyle(
              color: CustomColors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchURL(BuildContext context, {required String link}) async {
  final theme = Theme.of(context);
  try {
    await launchUrl(
      Uri.parse(link),
      customTabsOptions: CustomTabsOptions(
        colorSchemes: CustomTabsColorSchemes.defaults(
          toolbarColor: theme.colorScheme.surface,
          navigationBarColor: theme.colorScheme.background,
        ),
        urlBarHidingEnabled: true,
        showTitle: true,
        browser: const CustomTabsBrowserConfiguration(
          prefersDefaultBrowser: true,
        ),
      ),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}
