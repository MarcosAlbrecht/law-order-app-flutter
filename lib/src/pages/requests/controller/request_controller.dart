// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/constants/constants.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
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
      return StatusInfo('Cancelado', CustomColors.blueDarkColor, 0.3);
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

  final authController = Get.find<AuthController>();

  int pagination = 0;

  bool isLoading = false;

  String currentCategory = "received";

  List<RequestModel>? currentListRequest;

  List<RequestModel> allRequest = [];

  RequestModel? selectedRequest;

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

  Future<void> loadRequests(
      {bool canLoad = true,
      bool alterCategory = false,
      String sortDirection = 'DESC'}) async {
    if (canLoad) {
      setLoading(true, isUser: true);
    }
    var result;
    if (currentCategory == 'received') {
      result = await requestsRepository.getRequestsReceived(
          limit: itemsPerPage, skip: pagination, sortDirection: sortDirection);
    } else {
      result = await requestsRepository.getMyRequest(
          limit: itemsPerPage, skip: pagination);
    }
    setLoading(false, isUser: true);
    result.when(
      success: (data) {
        if (alterCategory) {
          allRequest.clear();
          currentListRequest = [];
        }

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
    currentCategory = value;
    pagination = 0;
    loadRequests(canLoad: true, alterCategory: true);
  }

  void handleSort({required String value}) {
    allRequest.clear();
    currentListRequest = [];
    pagination = 0;
    loadRequests(canLoad: true, sortDirection: value);
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
      currentListRequest = [];
      pagination = 0;
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
      //print(matchedEnumValue);
      String? statusEnumValue = matchedEnumValue ?? null;

      List<RequestModel> complexSearch = [];

      if (currentCategory == Constants.received) {
        complexSearch = allRequest.where(
          (request) {
            return (request.requester!.firstName!
                    .toLowerCase()
                    .contains(searchRequest.value) ||
                request.requester!.lastName!
                    .toLowerCase()
                    .contains(searchRequest.value) ||
                request.status == statusEnumValue ||
                utilServices
                    .priceToCurrency(request.total!)
                    .contains(searchRequest.value) ||
                request.createdAt!.contains(searchRequest.value));
          },
        ).toList();
      } else {
        complexSearch = allRequest.where(
          (request) {
            return (request.requested!.firstName!
                    .toLowerCase()
                    .contains(searchRequest.value) ||
                request.requested!.lastName!
                    .toLowerCase()
                    .contains(searchRequest.value) ||
                request.status == statusEnumValue ||
                utilServices
                    .priceToCurrency(request.total!)
                    .contains(searchRequest.value) ||
                request.createdAt!.contains(searchRequest.value));
          },
        ).toList();
      }

      allRequest.clear();
      allRequest.addAll(complexSearch);
      //allRequest.addAll(complexSearch1);
      //allRequest.addAll(complexSearch2);
    }
    setLoading(false, isUser: true);
  }

  void handleSelectedRequest({required RequestModel request}) {
    selectedRequest = request;

    Get.toNamed(PagesRoutes.requestDetailScreen);
  }
}
