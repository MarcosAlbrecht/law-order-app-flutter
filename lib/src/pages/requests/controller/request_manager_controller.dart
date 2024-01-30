import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/requests/controller/request_controller.dart';
import 'package:app_law_order/src/pages/requests/repository/request_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
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
  final utilServices = UtilServices();
  final requestController = Get.find<RequestController>();

  RequestModel? selectedRequest;
  String currentCategory = "received";

  bool isLoading = false;
  bool isSaving = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>;
    if (arguments['request'] == null) {
      loadRequest(idRequest: arguments['idRequest']);
    } else {
      selectedRequest = arguments['request'];
    }
    if (arguments['currentCategory'] != null) {
      currentCategory = arguments['currentCategory'];
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  void setSaving(bool value) {
    isLoading = value;
    update();
  }

  Future<void> loadRequest({required String idRequest}) async {
    setLoading(true);
    final result =
        await requestsRepository.getServiceRequestByID(idRequest: idRequest);
    setLoading(false);
    result.when(
      success: (data) {
        selectedRequest = data;
      },
      error: (message) {},
    );
  }

  Future<String?> handlePayment() async {
    String? retorno;
    final result = await requestsRepository.generatePaymentLink(
      value: selectedRequest!.total!,
      description: 'Prestadio',
      serviceRequestID: selectedRequest!.id!,
    );
    result.when(
      success: (data) {
        retorno = data;
      },
      error: (message) {
        utilServices.showToast(message: message);
        retorno = null;
      },
    );
    return retorno;
  }

  Future<void> openContest({required RequestModel request}) async {
    setSaving(true);
    final result = await requestsRepository.openContest(idRequest: request.id!);
    setSaving(false);
    result.when(success: (data) {}, error: (message) {});
  }

  Future<void> completeService({required RequestModel request}) async {
    setSaving(true);
    final result =
        await requestsRepository.completeService(idRequest: request.id!);
    setSaving(false);
    result.when(
      success: (data) {},
      error: (message) {},
    );
  }

  Future<void> cancelRequest({required RequestModel request}) async {
    setSaving(true);
    final result =
        await requestsRepository.cancelRequest(idRequest: request.id!);
    setSaving(false);
    await result.when(
        success: (data) async {
          await loadRequest(idRequest: selectedRequest!.id!);
          await updateSelectedCategory();
        },
        error: (message) {});
  }

  Future<void> updateSelectedCategory() async {
    await requestController.updateItemInAllRequests(request: selectedRequest!);
  }

  Future<void> handleProviderConfirmRequest({required DateTime date}) async {
    setSaving(true);
    final dataToIso = utilServices.formatDateToBD(date);
    final result = await requestsRepository.acceptProviderRequest(
        dataDeadline: dataToIso, idRequest: selectedRequest!.id!);
    setSaving(false);
    await result.when(
      success: (data) async {
        selectedRequest = data;
        //updateItemInAllRequests(request: data);
        await requestController.updateItemInAllRequests(
            request: selectedRequest!);
      },
      error: (message) {
        utilServices.showToast(
          message: message,
        );
      },
    );
  }

  StatusInfo serviceRequestStatus({required String status}) {
    UserServiceRequestStatusEnum statusEnum =
        UserServiceRequestStatusEnum.values.firstWhere(
            (e) => e.toString() == 'UserServiceRequestStatusEnum.$status');

    // Obtendo o texto e a cor correspondentes ao status
    StatusInfo statusInfo = getStatusInfo(statusEnum);
    return statusInfo;
  }
}
