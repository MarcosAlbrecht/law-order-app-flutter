import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/chat/controller/wallet_payments_controller.dart';
import 'package:app_law_order/src/pages/chat/view/components/payments_tile.dart';
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
              : RefreshIndicator(
                  color: CustomColors.white, // Define a cor de fundo do indicador
                  backgroundColor: CustomColors.blueDark2Color, // Define a cor de fundo da lista
                  strokeWidth: 3,
                  onRefresh: () async {
                    controller.getPaymentsWallet();
                  },
                  child: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Visibility(
                        visible: controller.listPayments.isNotEmpty,
                        replacement: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                color: CustomColors.blueDarkColor,
                              ),
                              const Text('Não há itens para apresentar'),
                            ],
                          ),
                        ),
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
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (_, index) {
                                    return PaymentsTile(
                                      payment: controller.listPayments[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) => const Divider(height: 10),
                                  itemCount: controller.listPayments.length),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
