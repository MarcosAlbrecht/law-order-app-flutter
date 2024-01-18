// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/pages/requests/controller/request_controller.dart';
import 'package:app_law_order/src/pages/requests/view/components/request_tile.dart';
import 'package:app_law_order/src/pages/requests/view/components/services_tile.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/requests/controller/request_detail_controller.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RequestDetailScreen extends StatelessWidget {
  const RequestDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        title: Text(
          'Solicitação',
          style: TextStyle(
            color: CustomColors.black,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Add the request details here
            _RequestDetails(),
            const SizedBox(height: 16.0),
            // Add the actions here
            _Actions(),
          ],
        ),
      ),
    );
  }
}

class _RequestDetails extends StatelessWidget {
  final utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Material(
            elevation: 4,
            color: CustomColors.cyanColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: GetBuilder<RequestController>(
              builder: (controller) {
                final statusInfo = controller.serviceRequestStatus(
                    status: controller.selectedRequest!.status!);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Solicitação de Serviço',
                        style: TextStyle(
                            fontSize: CustomFontSizes.fontSize20,
                            color: CustomColors.black),
                      ),
                      const Divider(
                        height: 20,
                      ),
                      _RowDetail(
                        'Data de Solicitação',
                        utilServices.formatDate(
                          controller.selectedRequest!.createdAt!,
                        ),
                      ),
                      const Divider(
                        height: 20,
                      ),
                      _RowDetail(
                        'Prazo',
                        utilServices.formatDate(
                          controller.selectedRequest!.deadline ?? '',
                        ),
                      ),
                      const Divider(
                        height: 20,
                      ),
                      _RowDetailServiceStatus('Status do Serviço',
                          statusInfo.text, statusInfo.color),
                      const Divider(
                        height: 20,
                      ),
                      _RowDetailStatusPayment('Status do Pagamento',
                          'Pagamento não realizado', Colors.red),

                      // _RowDetail('Serviços solicitados', 'Teste'),
                      // _RowDetail('Valor Total', 'R$ 1,00'),
                      // _RowDetail('Solicitante', 'Marcos Roberto Albrecht'),
                      // _RowDetail('Marechal Cândido Rondon', ''),
                      // SizedBox(height: 8.0),
                      // _RowDetail('Prestadio', ''),
                      // _RowDetail('Prestador', 'Leonardo Winter'),
                      // _RowDetail('Marechal Cândido Rondon', ''),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(
            height: 20,
            color: Colors.transparent,
          ),
          Material(
            elevation: 4,
            color: CustomColors.cyanColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: GetBuilder<RequestController>(
              builder: (controller) {
                final statusInfo = controller.serviceRequestStatus(
                    status: controller.selectedRequest!.status!);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Serviços Solicitados',
                        style: TextStyle(
                          fontSize: CustomFontSizes.fontSize20,
                          color: CustomColors.black,
                        ),
                      ),
                      const Divider(
                        height: 20,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                            itemBuilder: (_, index) {
                              return ServicesTile(
                                  service: controller.selectedRequest!
                                      .requestedServices![index]);
                            },
                            separatorBuilder: (_, index) => const Divider(
                                  height: 10,
                                ),
                            itemCount: controller
                                .selectedRequest!.requestedServices!.length),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Valor total'),
                          Text('Total'),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RowDetail extends StatelessWidget {
  final String label;
  final String value;

  _RowDetail(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: CustomColors.black,
                fontSize: CustomFontSizes.fontSize14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _RowDetailStatusPayment extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  _RowDetailStatusPayment(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: color,
          ),
          child: Text(
            value,
            style: TextStyle(
              color: CustomColors.white,
              fontSize: CustomFontSizes.fontSize12,
            ),
          ),
        ),
      ],
    );
  }
}

class _RowDetailServiceStatus extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  _RowDetailServiceStatus(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: color,
          ),
          child: Text(
            value,
            style: TextStyle(
              color: CustomColors.white,
              fontSize: CustomFontSizes.fontSize12,
            ),
          ),
        ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Add the chat button here
        _ChatButton(),
        // Add the service confirmation button here
        _ServiceConfirmationButton(),
        // Add the payment button here
        // _PaymentButton(),
        // // Add the evaluation button here
        // _EvaluationButton(),
        // // Add the dispute button here
        // _DisputeButton(),
        // // Add the cancellation button here
        // _CancelButton(),
      ],
    );
  }
}

class _ChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.blueDark2Color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add chat functionality here
      },
      child: Text(
        'Chat',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}

class _ServiceConfirmationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add service confirmation functionality here
      },
      child: Text(
        'Confirmar',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}

class _PaymentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add payment functionality here
      },
      child: Text(
        'Realizar pagamento',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}

class _EvaluationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add evaluation functionality here
      },
      child: Text(
        'Enviar avaliação',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}

class _DisputeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add dispute functionality here
      },
      child: Text(
        'Abrir disputa',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add cancellation functionality here
      },
      child: Text(
        'Cancelar',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}
