import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';

class MyWalletScreen extends StatelessWidget {
  MyWalletScreen({super.key});

  final utilService = UtilServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Minha carteira",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Informações da carteira',
                style: TextStyle(
                  color: CustomColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: CustomFontSizes.fontSize16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Aqui você pode visualizar as informações financeiras de sua conta!',
                style: TextStyle(
                  color: CustomColors.black,
                  //fontWeight: FontWeight.bold,
                  fontSize: CustomFontSizes.fontSize12,
                ),
              ),
              //const SizedBox(height: 16),
              const Divider(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Valor Total',
                      style: TextStyle(
                        color: CustomColors.blueDark2Color,
                        fontWeight: FontWeight.bold,
                        fontSize: CustomFontSizes.fontSize14,
                      ),
                    ),
                  ),
                  Text(
                    '${utilService.priceToCurrency(0)}',
                    style: TextStyle(
                      color: CustomColors.blueDarkColor,
                      fontWeight: FontWeight.bold,
                      fontSize: CustomFontSizes.fontSize16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Valor bloqueado',
                    style: TextStyle(
                      color: Color(0xfff59e0b),
                      fontWeight: FontWeight.bold,
                      fontSize: CustomFontSizes.fontSize14,
                    ),
                  ),
                  Text(
                    '${utilService.priceToCurrency(0)}',
                    style: TextStyle(
                      color: CustomColors.blueDarkColor,
                      fontWeight: FontWeight.bold,
                      fontSize: CustomFontSizes.fontSize16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Taxas',
                    style: TextStyle(
                      color: CustomColors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: CustomFontSizes.fontSize14,
                    ),
                  ),
                  Text(
                    '${utilService.priceToCurrency(0)}',
                    style: TextStyle(
                      color: CustomColors.blueDarkColor,
                      fontWeight: FontWeight.bold,
                      fontSize: CustomFontSizes.fontSize16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Disponível para saque',
                    style: TextStyle(
                      color: CustomColors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: CustomFontSizes.fontSize14,
                    ),
                  ),
                  Text(
                    '${utilService.priceToCurrency(0)}',
                    style: TextStyle(
                      color: CustomColors.blueDarkColor,
                      fontWeight: FontWeight.bold,
                      fontSize: CustomFontSizes.fontSize16,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 40,
              ),
              //botao para solicitar saque
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.blueDark2Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Solicitar saque',
                  style: TextStyle(
                    color: CustomColors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
