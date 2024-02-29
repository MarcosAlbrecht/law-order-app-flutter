import 'dart:io';

import 'package:app_law_order/src/config/app_data.dart';
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/constants/constants.dart';
import 'package:app_law_order/src/models/avaliation_model.dart';
import 'package:app_law_order/src/models/avaliation_values_model.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/models/status_info_model.dart';
import 'package:app_law_order/src/pages/requests/controller/request_controller.dart';
import 'package:app_law_order/src/pages/requests/repository/request_repository.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

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
      return StatusInfoModel(text: 'Aguardando Aceitação', color: Colors.blue, opacidade: 0.1);
    case UserServiceRequestStatusEnum.SCHEDULING:
      return StatusInfoModel(text: 'Em Agendamento', color: Colors.orange, opacidade: 0.1);
    case UserServiceRequestStatusEnum.CANCELED:
      return StatusInfoModel(text: 'Cancelado', color: CustomColors.blueDarkColor, opacidade: 0.3);
    case UserServiceRequestStatusEnum.EXPIRED:
      return StatusInfoModel(text: 'Expirado', color: Colors.grey, opacidade: 0.1);
    case UserServiceRequestStatusEnum.IN_CONTEST:
      return StatusInfoModel(text: 'Em Disputa', color: CustomColors.blueDarkColor, opacidade: 0.1);
    case UserServiceRequestStatusEnum.CONTEST_FINISHED:
      return StatusInfoModel(text: 'Disputa Finalizada', color: Colors.purple, opacidade: 0.1);
    case UserServiceRequestStatusEnum.COMPLETED:
      return StatusInfoModel(text: 'Finalizado', color: Colors.green, opacidade: 0.1);
    default:
      return StatusInfoModel(text: '', color: Colors.black, opacidade: 0.1);
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

  List<AvaliationValuesModel> avaliationsValues = avaliationValues;

  RequestModel? selectedRequest;
  late AvaliationModel avaliation;
  String currentCategory = "received";

  bool isLoading = true;
  bool isSaving = false;
  bool isLoadingFile = false;

  @override
  void onInit() async {
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>;
    if (arguments['request'] == null) {
      selectedRequest = RequestModel();
      await loadRequest(idRequest: arguments['idRequest']);
    } else {
      selectedRequest = arguments['request'];
      //setLoading(false);
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

  void setLoadingFile(bool value) {
    isLoadingFile = value;
    update();
  }

  void setCategory(RequestModel request) {
    if (request.requester != null) {
      currentCategory = Constants.sent;
    } else {
      currentCategory = Constants.received;
    }
  }

  Future<void> loadRequest({required String idRequest, canload = true}) async {
    if (canload) {
      setLoading(true);
    }

    final result = await requestsRepository.getServiceRequestByID(idRequest: idRequest);

    await result.when(
      success: (data) async {
        selectedRequest = data;
        setCategory(data);
        serviceRequestStatus(status: selectedRequest!.status!);
      },
      error: (message) {
        selectedRequest = RequestModel();
      },
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
    await result.when(
      success: (data) async {
        await loadRequest(idRequest: selectedRequest!.id!);
        await updateSelectedCategory();
      },
      error: (message) {},
    );
  }

  Future<void> completeService({required RequestModel request}) async {
    if (currentCategory == Constants.received) {
      setSaving(true);
      final result = await requestsRepository.completeService(idRequest: request.id!);
      setSaving(false);
      result.when(
        success: (data) {},
        error: (message) {},
      );
    } else {
      setSaving(true);

      final result = await requestsRepository.completeServiceUser(idRequest: request.id!);
      setSaving(false);
      await result.when(
        success: (data) async {
          await loadRequest(idRequest: selectedRequest!.id!);
          await updateSelectedCategory();
        },
        error: (message) {},
      );
    }
  }

  Future<void> cancelRequest({required RequestModel request}) async {
    setSaving(true);
    final result = await requestsRepository.cancelRequest(idRequest: request.id!);
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
    final result = await requestsRepository.acceptProviderRequest(dataDeadline: dataToIso, idRequest: selectedRequest!.id!);

    await result.when(
      success: (data) async {
        selectedRequest = data;
        //updateItemInAllRequests(request: data);
        await serviceRequestStatus(status: selectedRequest!.status!);
        await requestController.updateItemInAllRequests(request: selectedRequest!);
      },
      error: (message) {
        utilServices.showToast(
          message: message,
        );
      },
    );
    setSaving(false);
  }

  Future<void> serviceRequestStatus({required String status}) async {
    UserServiceRequestStatusEnum statusEnum =
        UserServiceRequestStatusEnum.values.firstWhere((e) => e.toString() == 'UserServiceRequestStatusEnum.$status');

    // Obtendo o texto e a cor correspondentes ao status
    StatusInfoModel statusInfo = getStatusInfo(statusEnum);
    selectedRequest?.statusPortuguese = statusInfo;
  }

  void handleInitAvaliation(RequestModel request) {
    avaliation = AvaliationModel();
    Get.toNamed(PagesRoutes.avaliationScreen, arguments: request);
  }

  Future<void> handleSubmitAvaliation() async {
    setSaving(true);

    avaliation.rating = ((avaliation.levelOfSatisfaction! + avaliation.serviceQuality! + avaliation.providerPunctuality!) / 3);
    avaliation.rating = double.parse(avaliation.rating!.toStringAsFixed(1));
    avaliation.jobId = selectedRequest!.id!;
    final result = await requestsRepository.sendAvaliation(avaliation: avaliation, requestedId: selectedRequest!.requested!.id!);
    setSaving(false);
    Get.back();
    result.when(
      success: (data) {
        utilServices.showToast(message: 'Avaliação enviada com sucesso!');
      },
      error: (data) {
        utilServices.showToast(message: 'Não foi possível enviar a avaliação!', isError: true);
      },
    );
  }

  Future<void> filePicker({required String idRequest}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      if ((files.length + selectedRequest!.files!.length) > 12) {
        utilServices.showToast(message: 'São permitidos apenas 12 arquivos');
        return;
      }
      handleUploadFile(files: files, idRequest: idRequest);
    }
  }

  Future<void> handleDeleteFile({required String idFile, required String idRequest}) async {
    setLoadingFile(true);
    final result = await requestsRepository.deleteFile(idFile: idFile, idRequest: idRequest);
    result.when(success: (message) {
      utilServices.showToast(message: message);
    }, error: (message) {
      utilServices.showToast(message: message);
    });
    await loadRequest(idRequest: idRequest, canload: false);
    setLoadingFile(false);
  }

  Future<void> handleUploadFile({
    required List<File> files,
    required String idRequest,
  }) async {
    setLoadingFile(true);
    final result = await requestsRepository.uploadFile(files: files, requestId: idRequest);
    result.when(success: (message) {
      utilServices.showToast(message: message);
    }, error: (message) {
      utilServices.showToast(message: message);
    });
    loadRequest(idRequest: idRequest, canload: false);
    setLoadingFile(false);
  }

  Future<void> handleDownloadFile({required String url, required String fileName}) async {
    setLoadingFile(true);
    final Directory appDocumentsDir;
    if (Platform.isIOS) {
      appDocumentsDir = (await getExternalStorageDirectory())!;
    } else {
      appDocumentsDir = (await getDownloadsDirectory())!;
    }

    if ((File('${appDocumentsDir.path}/$fileName').existsSync())) {
      print('arquivo ja foi baixado');
      //abrir arquivo baixado
    } else {
      String documentDir = '${appDocumentsDir.path}/$fileName';
      final result = await requestsRepository.downloadFile(url: url, savePath: documentDir);
      result.when(
          success: (data) {
            print('terminou o download');
          },
          error: (message) {});
    }
    setLoadingFile(false);

    await OpenFilex.open('${appDocumentsDir.path}/$fileName');
  }
}
