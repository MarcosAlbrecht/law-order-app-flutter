import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/constants/constants.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/models/status_info_model.dart';
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

StatusInfoModel getStatusInfo(UserServiceRequestStatusEnum status) {
  switch (status) {
    case UserServiceRequestStatusEnum.WAITING_PROVIDER_ACCEPT:
      return StatusInfoModel('Aguardando Aceitação', Colors.blue, 0.1);
    case UserServiceRequestStatusEnum.SCHEDULING:
      return StatusInfoModel('Em Agendamento', Colors.orange, 0.1);
    case UserServiceRequestStatusEnum.CANCELED:
      return StatusInfoModel('Cancelado', CustomColors.blueDarkColor, 0.3);
    case UserServiceRequestStatusEnum.EXPIRED:
      return StatusInfoModel('Expirado', Colors.grey, 0.1);
    case UserServiceRequestStatusEnum.IN_CONTEST:
      return StatusInfoModel('Em Disputa', CustomColors.blueDarkColor, 0.1);
    case UserServiceRequestStatusEnum.CONTEST_FINISHED:
      return StatusInfoModel('Disputa Finalizada', Colors.purple, 0.1);
    case UserServiceRequestStatusEnum.COMPLETED:
      return StatusInfoModel('Finalizado', Colors.green, 0.1);
    default:
      return StatusInfoModel('', Colors.black, 0.1);
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

class RequestManagerController extends GetxController {
  final requestsRepository = RequestRepository();
  final utilServices = UtilServices();
  final requestController = Get.find<RequestController>();

  RequestModel? selectedRequest;
  String currentCategory = "received";

  bool isLoading = true;
  bool isSaving = false;

  @override
  void onInit() async {
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>;
    if (arguments['request'] == null) {
      selectedRequest = RequestModel();
      await loadRequest(idRequest: arguments['idRequest']);
    } else {
      selectedRequest = arguments['request'];
      //isLoading = false;
      //selectedRequest = RequestModel();
      await loadRequest(idRequest: selectedRequest!.id!);
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

  void setCategory(RequestModel request) {
    if (request.requester != null) {
      currentCategory = Constants.sent;
    } else {
      currentCategory = Constants.received;
    }
  }

  Future<void> loadRequest({required String idRequest}) async {
    setLoading(true);
    final result =
        await requestsRepository.getServiceRequestByID(idRequest: idRequest);

    await result.when(
      success: (data) async {
        selectedRequest = data;
        setCategory(data);
        serviceRequestStatus(status: selectedRequest!.status!);
      },
      error: (message) {},
    );
    setLoading(false);
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

  void serviceRequestStatus({required String status}) {
    UserServiceRequestStatusEnum statusEnum =
        UserServiceRequestStatusEnum.values.firstWhere(
            (e) => e.toString() == 'UserServiceRequestStatusEnum.$status');

    // Obtendo o texto e a cor correspondentes ao status
    StatusInfoModel statusInfo = getStatusInfo(statusEnum);
    selectedRequest?.statusPortuguese = statusInfo;
  }
}
