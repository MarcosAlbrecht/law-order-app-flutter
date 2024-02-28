// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/constants/constants.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/requests/controller/request_manager_controller.dart';
import 'package:app_law_order/src/pages/requests/view/components/calendar_dialog.dart';
import 'package:app_law_order/src/pages/requests/view/components/cancel_confirmation_dialog.dart';
import 'package:app_law_order/src/pages/requests/view/components/contest_dialog.dart';
import 'package:app_law_order/src/pages/requests/view/components/services_tile.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class RequestManagerScreen extends StatelessWidget {
  const RequestManagerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        backgroundColor: CustomColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GetBuilder<RequestManagerController>(
            builder: (controller) {
              return Visibility(
                visible: !controller.isLoading,
                replacement: const Center(child: CircularProgressIndicator()),
                child: Visibility(
                  visible: controller.selectedRequest!.id != null,
                  replacement: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          color: CustomColors.blueDarkColor,
                        ),
                        const Text('Serviço não localizado!'),
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _RequestDetails(request: controller.selectedRequest!),
                        if (controller.currentCategory == Constants.received) _ActionsProvider(),
                        if (controller.currentCategory == Constants.sent) _ActionsUser(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RequestDetails extends StatelessWidget {
  final RequestModel request;
  final utilServices = UtilServices();

  _RequestDetails({
    Key? key,
    required this.request,
  }) : super(key: key);

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Solicitação de Serviço',
                    style: TextStyle(fontSize: CustomFontSizes.fontSize20, color: CustomColors.black),
                  ),
                  const Divider(
                    height: 20,
                  ),
                  _RowDetail(
                    'Data de Solicitação',
                    utilServices.formatDate(
                      request.createdAt ?? '',
                    ),
                  ),
                  const Divider(
                    height: 20,
                  ),
                  _RowDetail(
                    'Prazo',
                    utilServices.formatDate(
                      request.deadline ?? '',
                    ),
                  ),
                  const Divider(
                    height: 20,
                  ),
                  _RowDetailServiceStatus(
                    'Status do Serviço',
                    request.statusPortuguese!.text!,
                    request.statusPortuguese!.color!,
                  ),
                  const Divider(
                    height: 20,
                  ),
                  request.paid
                      ? _RowDetailStatusPayment('Status do Pagamento', 'Pagamento realizado', Colors.green)
                      : _RowDetailStatusPayment('Status do Pagamento', 'Pagamento não realizado', Colors.red),
                ],
              ),
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
            child: GetBuilder<RequestManagerController>(
              builder: (controller) {
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
                              return ServicesTile(service: controller.selectedRequest!.requestedServices![index]);
                            },
                            separatorBuilder: (_, index) => const Divider(
                                  height: 10,
                                ),
                            itemCount: controller.selectedRequest!.requestedServices!.length),
                      ),
                      const Divider(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 24, left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Valor total'),
                            Text(
                              utilServices.priceToCurrency(controller.selectedRequest!.total!),
                              style: TextStyle(
                                fontSize: CustomFontSizes.fontSize14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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
            child: GetBuilder<RequestManagerController>(
              builder: (controller) {
                return ExpansionTile(
                  shape: Border.all(color: Colors.transparent),
                  title: Text('Arquivos (${controller.selectedRequest!.files?.length ?? '0'})'),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.selectedRequest?.files?.length ?? 0,
                      itemBuilder: (context, index) {
                        dynamic file = controller.selectedRequest!.files?[index];
                        return ListTile(
                          dense: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: controller.isLoadingFile
                                    ? const CircularProgressIndicator(strokeWidth: 2)
                                    : const Icon(
                                        Icons.download_outlined,
                                        size: 20,
                                      ),
                                onPressed: () {
                                  controller.handleDownloadFile(
                                    url: file['url']!,
                                    fileName: file['key']!,
                                  );
                                  // Adicione aqui a lógica para excluir o arquivo
                                },
                              ),
                              Expanded(
                                  child:
                                      Text(file['key']!)), // Supondo que o título do arquivo esteja armazenado na chave 'title'
                              IconButton(
                                icon: controller.isLoadingFile
                                    ? const CircularProgressIndicator(strokeWidth: 2)
                                    : const Icon(
                                        FontAwesome.trash_empty,
                                        size: 20,
                                      ),
                                onPressed: () {
                                  controller.handleDeleteFile(
                                    idFile: file['_id']!,
                                    idRequest: controller.selectedRequest!.id!,
                                  );
                                  // Adicione aqui a lógica para excluir o arquivo
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.filePicker(idRequest: controller.selectedRequest!.id!);
                          },
                          child: controller.isLoadingFile
                              ? const CircularProgressIndicator(strokeWidth: 2)
                              : const Text('Escolher arquivos'),
                        ),
                      ],
                    )
                  ],
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
            style: TextStyle(color: CustomColors.black, fontSize: CustomFontSizes.fontSize14, fontWeight: FontWeight.bold),
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
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
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
              fontSize: CustomFontSizes.fontSize10,
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
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
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
              fontSize: CustomFontSizes.fontSize10,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionsProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GetBuilder<RequestManagerController>(
        builder: (controller) {
          List<Widget> actionWidgets = [];

          //verifica o tipo de usuário pra montar o botao de chat
          String? labelButton = 'Conversar com o solicitante';

          switch (controller.selectedRequest?.status) {
            case 'WAITING_PROVIDER_ACCEPT':
              actionWidgets.add(_ServiceConfirmationRefuseButton(currentCategory: controller.currentCategory));
              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );
              actionWidgets.add(
                _DisputeButton(
                  currentCategory: controller.currentCategory,
                  request: controller.selectedRequest!,
                ),
              );
              break;
            case 'SCHEDULING':
              actionWidgets.add(_ServiceFinalizedConfirmationRefuseButtonProvider(
                currentCategory: controller.currentCategory,
                request: controller.selectedRequest!,
              ));
              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );
              actionWidgets.add(
                _ChatButton(
                  labelButton: labelButton,
                  destinationUserId: controller.selectedRequest!.requester!.id!,
                ),
              );
              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );
              actionWidgets.add(
                _DisputeButton(
                  currentCategory: controller.currentCategory,
                  request: controller.selectedRequest!,
                ),
              );
            case 'COMPLETED':
              actionWidgets.add(
                Text(
                  'Ações',
                  style: TextStyle(
                    fontSize: CustomFontSizes.fontSize16,
                    color: CustomColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
              actionWidgets.add(
                _ChatButton(
                  labelButton: labelButton,
                  destinationUserId: controller.selectedRequest!.requester!.id!,
                ),
              );

              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );
              actionWidgets.add(
                _DisputeButton(
                  currentCategory: controller.currentCategory,
                  request: controller.selectedRequest!,
                ),
              );
            case 'CANCELED':
              actionWidgets.add(
                Text(
                  'Ações',
                  style: TextStyle(
                    fontSize: CustomFontSizes.fontSize16,
                    color: CustomColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
              actionWidgets.add(
                _ChatButton(
                  labelButton: labelButton,
                  destinationUserId: controller.selectedRequest!.requester!.id!,
                ),
              );

              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );
              actionWidgets.add(
                _DisputeButton(
                  currentCategory: controller.currentCategory,
                  request: controller.selectedRequest!,
                ),
              );
            case 'IN_CONTEST':
              actionWidgets.add(
                _ServiceFinalizedConfirmationRefuseButtonProvider(
                  currentCategory: controller.currentCategory,
                  request: controller.selectedRequest!,
                ),
              );
              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );

              actionWidgets.add(
                _ChatButton(
                  labelButton: labelButton,
                  destinationUserId: controller.selectedRequest!.requester!.id!,
                ),
              );

              break;
            default:
            // Lida com outros casos ou não faz nada
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: actionWidgets,
          );
        },
      ),
    );
  }
}

class _ActionsUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GetBuilder<RequestManagerController>(
        builder: (controller) {
          List<Widget> actionWidgets = [];

          //verifica o tipo de usuário pra montar o botao de chat
          String? labelButton = 'Conversar com o prestador';

          switch (controller.selectedRequest?.status) {
            case 'WAITING_PROVIDER_ACCEPT':
              actionWidgets.add(_ChatButton(
                labelButton: labelButton,
                destinationUserId: controller.selectedRequest!.requested!.id!,
              ));
              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );
              actionWidgets.add(_EvaluationButton(
                request: controller.selectedRequest!,
              ));
              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );
              actionWidgets.add(
                _DisputeButton(
                  currentCategory: controller.currentCategory,
                  request: controller.selectedRequest!,
                ),
              );
              break;
            case 'SCHEDULING':
              actionWidgets.add(
                _ServiceFinalizedConfirmationRefuseButtonUser(
                  currentCategory: controller.currentCategory,
                  request: controller.selectedRequest!,
                ),
              );
              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );
              actionWidgets.add(
                _ChatButton(
                  labelButton: labelButton,
                  destinationUserId: controller.selectedRequest!.requested!.id!,
                ),
              );
              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );

              actionWidgets.add(
                _PaymentButton(),
              );

              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );

              actionWidgets.add(_EvaluationButton(
                request: controller.selectedRequest!,
              ));

              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );

              actionWidgets.add(
                _DisputeButton(
                  currentCategory: controller.currentCategory,
                  request: controller.selectedRequest!,
                ),
              );
            case 'COMPLETED':
              actionWidgets.add(
                Text(
                  'Ações',
                  style: TextStyle(
                    fontSize: CustomFontSizes.fontSize16,
                    color: CustomColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );

              actionWidgets.add(
                _ChatButton(
                  labelButton: labelButton,
                  destinationUserId: controller.selectedRequest!.requested!.id!,
                ),
              );

              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );

              actionWidgets.add(
                _PaymentButton(),
              );

              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );

              actionWidgets.add(
                _EvaluationButton(request: controller.selectedRequest!),
              );

              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );
              actionWidgets.add(
                _DisputeButton(
                  currentCategory: controller.currentCategory,
                  request: controller.selectedRequest!,
                ),
              );
            case 'CANCELED':
              actionWidgets.add(
                Text(
                  'Ações',
                  style: TextStyle(
                    fontSize: CustomFontSizes.fontSize16,
                    color: CustomColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
              actionWidgets.add(
                _ChatButton(
                  labelButton: labelButton,
                  destinationUserId: controller.selectedRequest!.requested!.id!,
                ),
              );

              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );
              actionWidgets.add(_EvaluationButton(
                request: controller.selectedRequest!,
              ));
              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );
              actionWidgets.add(
                _DisputeButton(
                  currentCategory: controller.currentCategory,
                  request: controller.selectedRequest!,
                ),
              );

            case 'IN_CONTEST':
              actionWidgets.add(
                _ServiceFinalizedConfirmationRefuseButtonUser(
                  currentCategory: controller.currentCategory,
                  request: controller.selectedRequest!,
                ),
              );
              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );

              actionWidgets.add(
                _ChatButton(
                  labelButton: labelButton,
                  destinationUserId: controller.selectedRequest!.requested!.id!,
                ),
              );

              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );

              actionWidgets.add(
                _PaymentButton(),
              );
              actionWidgets.add(
                const Divider(
                  height: 20,
                ),
              );

              actionWidgets.add(
                _EvaluationButton(request: controller.selectedRequest!),
              );

              break;
            default:
            // Lida com outros casos ou não faz nada
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: actionWidgets,
          );
        },
      ),
    );
  }
}

class _ChatButton extends StatelessWidget {
  final String destinationUserId;
  String labelButton;
  _ChatButton({
    Key? key,
    required this.destinationUserId,
    required this.labelButton,
  }) : super(key: key);
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
        Get.toNamed(
          PagesRoutes.chatMessageScreen,
          arguments: {'userDestinationId': destinationUserId},
        );
      },
      child: Text(
        labelButton,
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}

class _ServiceConfirmationRefuseButton extends StatelessWidget {
  final String currentCategory;

  const _ServiceConfirmationRefuseButton({super.key, required this.currentCategory});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ações',
          style: TextStyle(
            fontSize: CustomFontSizes.fontSize16,
            color: CustomColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Add service confirmation functionality here
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CalendarDialog();
                  },
                );
              },
              child: Text(
                'Aceitar Solicitação',
                style: TextStyle(
                  color: CustomColors.white,
                  fontSize: CustomFontSizes.fontSize14,
                ),
              ),
            ),
            const VerticalDivider(
              width: 5,
              color: Colors.transparent,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Add service confirmation functionality here
              },
              child: Text(
                'Recusar Solicitação',
                style: TextStyle(
                  color: CustomColors.white,
                  fontSize: CustomFontSizes.fontSize14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceFinalizedConfirmationRefuseButtonProvider extends StatelessWidget {
  final String currentCategory;
  final RequestModel request;

  const _ServiceFinalizedConfirmationRefuseButtonProvider({
    super.key,
    required this.currentCategory,
    required this.request,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ações',
          style: TextStyle(
            fontSize: CustomFontSizes.fontSize16,
            color: CustomColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        GetBuilder<RequestManagerController>(
          builder: (controller) {
            return Row(
              children: [
                Expanded(
                  child: ElevatedButton(
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
                  ),
                ),
                const VerticalDivider(
                  width: 5,
                  color: Colors.transparent,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      // Add service confirmation functionality here
                      final bool? result = await showDialog(
                        context: context,
                        builder: (_) {
                          return const CancelConfirmationDialog();
                        },
                      );
                      if (result ?? false) {
                        controller.cancelRequest(request: request);
                      }
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: CustomColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ServiceFinalizedConfirmationRefuseButtonUser extends StatelessWidget {
  final String currentCategory;
  final RequestModel request;

  const _ServiceFinalizedConfirmationRefuseButtonUser({super.key, required this.currentCategory, required this.request});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ações',
          style: TextStyle(
            fontSize: CustomFontSizes.fontSize16,
            color: CustomColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        GetBuilder<RequestManagerController>(
          builder: (controller) {
            return Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Add service confirmation functionality here
                      controller.completeService(request: request);
                    },
                    child: Text(
                      'Confirmar',
                      style: TextStyle(
                        color: CustomColors.white,
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  width: 5,
                  color: Colors.transparent,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Add service confirmation functionality here
                      controller.cancelRequest(request: request);
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: CustomColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _PaymentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestManagerController>(
      builder: (controller) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.blueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            final link = await controller.handlePayment();
            if (link != null) {
              _launchURL(context, link: link);
            }
            // Add payment functionality here
          },
          child: Text(
            'Realizar pagamento',
            style: TextStyle(
              color: CustomColors.white,
            ),
          ),
        );
      },
    );
  }
}

class _EvaluationButton extends StatelessWidget {
  final RequestModel request;

  const _EvaluationButton({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestManagerController>(
      builder: (controller) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.backgroudCard,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Add evaluation functionality here
            controller.handleInitAvaliation(request);
          },
          child: Text(
            'Enviar avaliação',
            style: TextStyle(
              color: CustomColors.black,
            ),
          ),
        );
      },
    );
  }
}

class _DisputeButton extends StatelessWidget {
  final String currentCategory;
  final RequestModel request;

  const _DisputeButton({
    Key? key,
    required this.currentCategory,
    required this.request,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.blueDarkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add dispute functionality here
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ContestDialog(
              request: request,
              selectedCategory: currentCategory,
            );
          },
        );
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
