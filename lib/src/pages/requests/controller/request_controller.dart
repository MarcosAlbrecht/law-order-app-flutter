// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/requests/repository/request_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';

const int itemsPerPage = 10;

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
      return StatusInfo('Cancelado', Colors.red, 0.3);
    case UserServiceRequestStatusEnum.EXPIRED:
      return StatusInfo('Expirado', Colors.grey, 0.1);
    case UserServiceRequestStatusEnum.IN_CONTEST:
      return StatusInfo('Em Disputa', Colors.yellow, 0.1);
    case UserServiceRequestStatusEnum.CONTEST_FINISHED:
      return StatusInfo('Disputa Finalizada', Colors.purple, 0.1);
    case UserServiceRequestStatusEnum.COMPLETED:
      return StatusInfo('Concluído', Colors.green, 0.1);
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

class RequestController extends GetxController {
  final requestsRepository = RequestRepository();
  final utilServices = UtilServices();

  int pagination = 0;

  bool isLoading = false;

  String currentCategory = "received";

  List<RequestModel>? currentListRequest;

  List<RequestModel> allRequest = [];

  RxString searchRequest = ''.obs;

  bool get isLastPage {
    if (currentListRequest!.length < itemsPerPage) return true;

    return pagination + itemsPerPage > allRequest.length;
  }

  @override
  void onInit() {
    super.onInit();

    debounce(
      searchRequest,
      (_) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );

    loadRequests();
  }

  void setLoading(bool value, {bool isUser = false}) {
    if (isUser) {
      isLoading = value;
    }
    update();
  }

  Future<void> loadRequests({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isUser: true);
    }
    final result = await requestsRepository.getRequestsReceived(
        limit: itemsPerPage, skip: pagination);

    setLoading(false, isUser: true);
    result.when(
      success: (data) {
        currentListRequest = data;
        allRequest.addAll(currentListRequest!);
      },
      error: (message) {},
    );
  }

  void loadMoreRequestsReceived() {
    pagination = pagination + 10;
    loadRequests(canLoad: false);
  }

  void selectCategory({required String value}) {
    setLoading(true);
    currentCategory = value;

    //carregar itens da api
    setLoading(true);
  }

  StatusInfo serviceRequestStatus({required String status}) {
    UserServiceRequestStatusEnum statusEnum =
        UserServiceRequestStatusEnum.values.firstWhere(
            (e) => e.toString() == 'UserServiceRequestStatusEnum.$status');

    // Obtendo o texto e a cor correspondentes ao status
    StatusInfo statusInfo = getStatusInfo(statusEnum);
    return statusInfo;
  }

  void filterByTitle() {
    setLoading(true, isUser: true);
    if (searchRequest.value.isEmpty) {
      allRequest.clear();
      loadRequests(canLoad: false);
    } else {
      String? matchedEnumValue;

      //buscar se contem algo no status
      customStatusMapping.forEach(
        (key, value) {
          if (value.toLowerCase().contains(searchRequest.value.toLowerCase())) {
            matchedEnumValue = key.toString().split('.').last;
            return;
          }
        },
      );
      print(matchedEnumValue);
      String statusEnumValue = matchedEnumValue ?? '';

      List<RequestModel> complexSearch = allRequest.where(
        (request) {
          return request.requester!.firstName!
                  .toLowerCase()
                  .contains(searchRequest.value) ||
              request.status!.contains(statusEnumValue) ||
              request.createdAt!.contains(searchRequest.value) ||
              request.total.toString().contains(searchRequest.value) ||
              (request.deadline ?? '').contains(searchRequest.value);
        },
      ).toList();
      allRequest.clear();
      allRequest.addAll(complexSearch);
    }
    setLoading(false, isUser: true);
  }
}
