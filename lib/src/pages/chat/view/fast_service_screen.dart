// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/chat/controller/chat_controller.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FastServiceScreen extends StatefulWidget {
  final String name;
  final String userId;
  const FastServiceScreen({
    Key? key,
    required this.name,
    required this.userId,
  }) : super(key: key);

  @override
  State<FastServiceScreen> createState() => _FastServiceScreenState();
}

final valueEC = TextEditingController();
final CurrencyTextInputFormatter formatterEC = CurrencyTextInputFormatter.currency(decimalDigits: 2, locale: 'pt', symbol: 'R\$');

cleanText() {
  valueEC.clear();
  formatterEC.val('');
}

class _FastServiceScreenState extends State<FastServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Typicons.flash_outline,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Serviço rápido',
                    style: TextStyle(
                      fontSize: CustomFontSizes.fontSize16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Como funciona?',
                        style: TextStyle(
                          fontSize: CustomFontSizes.fontSize16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Se você já combinou o valor do serviço que deseja com o Prestador, pode enviar o valor combinado por meio da contratação rápida.\n'
                    'É fácil e seguro! O dinheiro fica com a Prestadio até você confirmar a realização do serviço!',
                    style: TextStyle(
                      fontSize: CustomFontSizes.fontSize14,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.attach_money_outlined,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Enviar dinheiro',
                        style: TextStyle(
                          fontSize: CustomFontSizes.fontSize16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Qual valor você deseja enviar para ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: CustomFontSizes.fontSize16,
                          ),
                        ),
                        TextSpan(
                          text: widget.name,
                          style: TextStyle(
                            color: CustomColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: CustomFontSizes.fontSize16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                textInputType: TextInputType.number,
                contentPadding: false,
                paddingBottom: false,
                inputFormatters: <TextInputFormatter>[formatterEC],
                controller: valueEC,
                onChanged: (value) {
                  //chavePixEC.text = value ?? '';
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<ChatController>(
                builder: (controller) {
                  return SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        final link =
                            await controller.generatePayment(value: formatterEC.getUnformattedValue(), userId: widget.userId);
                        if (link.isNotEmpty) {
                          _launchURL(context, link: link);
                        }

                        print(formatterEC.getUnformattedValue());
                        cleanText();
                      },
                      child: Text(
                        'Enviar',
                        style: TextStyle(
                          color: CustomColors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
