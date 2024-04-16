import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/chat/controller/wallet_payments_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PaymentsWalletScreen extends StatefulWidget {
  const PaymentsWalletScreen({super.key});

  @override
  State<PaymentsWalletScreen> createState() => _PaymentsWalletScreenState();
}

class _PaymentsWalletScreenState extends State<PaymentsWalletScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        title: Text(
          "Pagamentos",
          style: TextStyle(color: CustomColors.black),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: GetBuilder<WalletPaymentsController>(
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    color: CustomColors.blueDark2Color,
                    secondRingColor: CustomColors.blueDarkColor,
                    thirdRingColor: CustomColors.blueColor,
                    size: 50,
                  ),
                )
              : SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Pagamentos para ${controller.user.firstName!}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: CustomFontSizes.fontSize16),
                        ),
                        const Divider(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
