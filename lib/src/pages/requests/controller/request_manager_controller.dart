import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/requests/controller/request_controller.dart';
import 'package:app_law_order/src/pages/requests/repository/request_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UserServiceRequestStatusEnum {
  WAITING_PROVIDER_ACCEPT,
  SCHEDULING,
  CANCELED,
  EXPIRED,
  IN_CONTEST,
  CONTEST_FINISHED,
  COMPLETED
}

StatusInfo getStatusInfo(UserServiceRequestStatusEnum status) {
  switch (status) {
    case UserServiceRequestStatusEnum.WAITING_PROVIDER_ACCEPT:
      return StatusInfo('Aguardando Aceitação', Colors.blue, 0.1);
    case UserServiceRequestStatusEnum.SCHEDULING:
      return StatusInfo('Em Agendamento', Colors.orange, 0.1);
    case UserServiceRequestStatusEnum.CANCELED:
      return StatusInfo('Cancelado', CustomColors.blueDarkColor, 0.3);
    case UserServiceRequestStatusEnum.EXPIRED:
      return StatusInfo('Expirado', Colors.grey, 0.1);
    case UserServiceRequestStatusEnum.IN_CONTEST:
      return StatusInfo('Em Disputa', CustomColors.blueDarkColor, 0.1);
    case UserServiceRequestStatusEnum.CONTEST_FINISHED:
      return StatusInfo('Disputa Finalizada', Colors.purple, 0.1);
    case UserServiceRequestStatusEnum.COMPLETED:
      return StatusInfo('Finalizado', Colors.green, 0.1);
    default:
      return StatusInfo('', Colors.black, 0.1);
  }
}

Map<UserServiceRequestStatusEnum, String> customStatusMapping = {
  UserServiceRequestStatusEnum.WAITING_PROVIDER_ACCEPT: 'aguardando aceitação',
  UserServiceRequestStatusEnum.SCHEDULING: 'em agendamento',
  UserServiceRequestStatusEnum.CANCELED: 'cancelado',
  UserServiceRequestStatusEnum.EXPIRED: 'expirado',
  UserServiceRequestStatusEnum.IN_CONTEST: 'em disputa',
  UserServiceRequestStatusEnum.CONTEST_FINISHED: 'disputa finalizada',
  UserServiceRequestStatusEnum.COMPLETED: 'concluído',
};

class StatusInfo {
  final String text;
  final Color color;
  double opacidade;

  StatusInfo(
    this.text,
    this.color,
    this.opacidade,
  );
}

class RequestManagerController extends GetxController {
  final requestsRepository = RequestRepository();

  final requestController = Get.find<RequestController>();

  RequestModel? selectedRequest;
  String currentCategory = "received";
}
