import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/profile/controller/withdraw_controller.dart';
import 'package:app_law_order/src/pages/profile/view/components/pix_dialog.dart';
import 'package:app_law_order/src/pages/profile/view/components/withdraw_history_tile.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WithdrawScreen extends StatefulWidget {
  WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

final utilServices = UtilServices();

final valueEC = TextEditingController();
final CurrencyTextInputFormatter formatterEC = CurrencyTextInputFormatter.currency(decimalDigits: 2, locale: 'pt', symbol: 'R\$');

cleanText() {
  valueEC.clear();
  formatterEC.val('');
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Requisições de Saque",
          style: TextStyle(color: CustomColors.black),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: CustomColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<WithDrawController>(
          builder: (controller) {
            return SizedBox(
              //color: Colors.amber,
              height: size.height,
              width: size.width,
              child: controller.isLoading
                  ? Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: CustomColors.blueDark2Color,
                        secondRingColor: CustomColors.blueDarkColor,
                        thirdRingColor: CustomColors.blueColor,
                        size: 50,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Aqui você pode visualizar e solicitar saques e difinir uma chave PIX para receber os pagamentos',
                          ),
                          const Divider(
                            height: 40,
                          ),
                          Text(
                            'Pix',
                            style: TextStyle(
                              fontSize: CustomFontSizes.fontSize14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Chave pix para aonde serão enviados os saques',
                            style: TextStyle(
                              fontSize: CustomFontSizes.fontSize12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Icon(
                                      Icons.pix,
                                      color: Color(
                                        0XFF00bdaf,
                                      ),
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.user.pix != null
                                            ? controller.user.pix!.firstWhereOrNull((e) => e.active == true)?.key ??
                                                'Nenhuma chave cadastrada'
                                            : 'Nenhuma chave cadastrada',
                                        style: TextStyle(
                                          fontSize: CustomFontSizes.fontSize14,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GetBuilder<WithDrawController>(
                                builder: (controller) {
                                  return Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        visualDensity: VisualDensity.compact,
                                        padding: const EdgeInsets.all(18),
                                        backgroundColor: CustomColors.blueDark2Color,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () async {
                                        controller.handleShowClosePixDialog('show');
                                        final canceled = await showDialog(
                                          context: context,
                                          builder: (_) {
                                            return PixDialog();
                                          },
                                        );
                                      },
                                      child: Text(
                                        'Alterar Pix',
                                        style: TextStyle(
                                          color: CustomColors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  );
                                },
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
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Saldo disponível:',
                                        style: TextStyle(
                                            color: CustomColors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: CustomFontSizes.fontSize16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        utilServices.priceToCurrency(controller.wallet.realizado ?? 0),
                                        style: TextStyle(
                                            color: CustomColors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: CustomFontSizes.fontSize20),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text('Prazo de 7 dias para a conclusão do saque'),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Valor solicitado',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              //container com campo e botao para solicitar valor
                              SizedBox(
                                height: 43,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        textInputType: TextInputType.number,
                                        contentPadding: false,
                                        paddingBottom: false,
                                        inputFormatters: <TextInputFormatter>[formatterEC],
                                        controller: valueEC,
                                        onChanged: (value) {
                                          //chavePixEC.text = value ?? '';
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GetBuilder<WithDrawController>(
                                      builder: (controller) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(vertical: 1),
                                          height: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              //visualDensity: VisualDensity.compact,
                                              //padding: const EdgeInsets.all(15),
                                              backgroundColor: CustomColors.blueDark2Color.withOpacity(1),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                              controller.handleRequestWithdraw(formatterEC.getUnformattedValue());
                                              print(formatterEC.getUnformattedValue());
                                              cleanText();
                                            },
                                            child: Text(
                                              'Solicitar',
                                              style: TextStyle(
                                                color: CustomColors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 40,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Histórico',
                                style: TextStyle(
                                  fontSize: CustomFontSizes.fontSize14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Visibility(
                                visible: controller.withdraws.isNotEmpty,
                                replacement: const Text('Nenhuma solicitação encontrada ainda.'),
                                child: SizedBox(
                                  height: 200,
                                  //color: Colors.red,
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return WithdrawHistoryTile(
                                          withdraw: controller.withdraws[index],
                                        );
                                      },
                                      separatorBuilder: (context, index) => const SizedBox(
                                            height: 20,
                                          ),
                                      itemCount: controller.withdraws.length),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
