import 'dart:developer';
import 'dart:io';

import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/avaliation_model.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/chat/result/send_file_result.dart';
import 'package:app_law_order/src/pages/requests/result/acceptance_request_result.dart';
import 'package:app_law_order/src/pages/requests/result/download_file_request_result.dart';
import 'package:app_law_order/src/pages/requests/result/payment_link_result.dart';
import 'package:app_law_order/src/pages/requests/result/request_received_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:dio/dio.dart';

class RequestRepository {
  final HttpManager httpManager = HttpManager();
  final utilServices = UtilServices();

  Future<RequestReceivedResult<RequestModel>> getRequestsReceived(
      {required int limit, required int skip, String sortDirection = 'DESC'}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.get,
        url: EndPoints.getRequestsReceived,
        queryParams: {
          'limit': limit,
          'skip': skip,
          'sortColumn': 'createdAt',
          'sortDirection': "ASC",
        },
      );

      if (result['result'].isNotEmpty) {
        List<RequestModel> data = (List<Map<String, dynamic>>.from(result['result'])).map(RequestModel.fromJson).toList();
        return RequestReceivedResult.success(data);
      } else {
        if (result['result'] != null) {
          List<RequestModel> data = [];
          return RequestReceivedResult.success(data);
        } else {
          return RequestReceivedResult.error("Não foi possível buscar os dados!");
        }
      }
    } on Exception {
      return RequestReceivedResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<RequestReceivedResult<RequestModel>> getMyRequest(
      {required int limit, required int skip, String sortDirection = 'ASC'}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.get,
        url: EndPoints.getMyRequest,
        queryParams: {
          'limit': limit,
          'skip': skip,
          'sortColumn': 'createdAt',
          'sortDirection': sortDirection,
        },
      );

      if (result['result'].isNotEmpty) {
        List<RequestModel> data = (List<Map<String, dynamic>>.from(result['result'])).map(RequestModel.fromJson).toList();

        return RequestReceivedResult.success(data);
      } else {
        if (result['statusCode'] != null) {
          return RequestReceivedResult.error("Não foi possível buscar os dados!");
        } else {
          List<RequestModel> data = [];
          return RequestReceivedResult.success(data);
        }
      }
    } on Exception {
      return RequestReceivedResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<AcceptanceRequestResult> acceptProviderRequest({required String dataDeadline, required String idRequest}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.patch,
        url: '${EndPoints.acceptBudget}$idRequest',
        body: {
          "providerAcceptance": true,
          "deadline": dataDeadline,
        },
      );

      if (result.isNotEmpty) {
        var userData = result as Map<String, dynamic>;
        RequestModel data = RequestModel.fromJson(userData);

        return AcceptanceRequestResult.success(data);
      } else {
        return AcceptanceRequestResult.error("Não foi possível buscar os dados!");
      }
    } on Exception {
      return AcceptanceRequestResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<AcceptanceRequestResult> getServiceRequestByID({required String idRequest}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.get,
        url: '${EndPoints.getRequestsReceivedById}$idRequest',
      );

      if (result.isNotEmpty && result['statusCode'] == null) {
        var userData = result as Map<String, dynamic>;
        RequestModel data = RequestModel.fromJson(userData);

        return AcceptanceRequestResult.success(data);
      } else {
        return AcceptanceRequestResult.error("Não foi possível buscar os dados!");
      }
    } on Exception {
      return AcceptanceRequestResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<RequestReceivedResult<RequestModel>> declineBudget({
    required int idRequest,
  }) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.patch,
        url: '${EndPoints.declineBudget} ',
      );

      if (result['result'].isNotEmpty) {
        List<RequestModel> data = (List<Map<String, dynamic>>.from(result['result'])).map(RequestModel.fromJson).toList();

        return RequestReceivedResult.success(data);
      } else {
        return RequestReceivedResult.error("Não foi possível buscar os dados!");
      }
    } on Exception {
      return RequestReceivedResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<RequestReceivedResult<RequestModel>> openContest({
    required String idRequest,
  }) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.patch,
        url: '${EndPoints.openContest} $idRequest',
      );

      if (result['statusCode'] == null) {
        List<RequestModel> data = (List<Map<String, dynamic>>.from(result['result'])).map(RequestModel.fromJson).toList();

        return RequestReceivedResult.success(data);
      } else {
        if (result['statusCode'] == 500) {
          return RequestReceivedResult.error("Erro interno, tente novamente mais tarde!");
        } else {
          return RequestReceivedResult.error("Não foi possível buscar os dados!");
        }
      }
    } on Exception {
      return RequestReceivedResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<RequestReceivedResult<RequestModel>> completeService({
    required String idRequest,
  }) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.patch,
        url: '${EndPoints.completeService}$idRequest',
      );

      if (result.isEmpty) {
        List<RequestModel> data = [];

        return RequestReceivedResult.success(data);
      } else {
        if (result['statusCode'] == 500) {
          return RequestReceivedResult.error("Erro interno, tente novamente mais tarde!");
        } else {
          return RequestReceivedResult.error("Não foi possível buscar os dados!");
        }
      }
    } on Exception {
      return RequestReceivedResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<RequestReceivedResult<RequestModel>> completeServiceUser({
    required String idRequest,
  }) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.patch,
        url: '${EndPoints.completeServiceUser}$idRequest',
      );

      if (result.isEmpty) {
        List<RequestModel> data = [];

        return RequestReceivedResult.success(data);
      } else {
        if (result['statusCode'] == 500) {
          return RequestReceivedResult.error("Erro interno, tente novamente mais tarde!");
        } else {
          return RequestReceivedResult.error("Não foi possível buscar os dados!");
        }
      }
    } on Exception {
      return RequestReceivedResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<RequestReceivedResult<RequestModel>> cancelRequest({
    required String idRequest,
  }) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.patch,
        url: '${EndPoints.cancelRequest}$idRequest',
      );

      if (result.isEmpty) {
        List<RequestModel> data = [];

        return RequestReceivedResult.success(data);
      } else {
        if (result['statusCode'] == 500) {
          return RequestReceivedResult.error("Erro interno, tente novamente mais tarde!");
        } else {
          return RequestReceivedResult.error("Não foi possível buscar os dados!");
        }
      }
    } on Exception {
      return RequestReceivedResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<RequestReceivedResult<RequestModel>> sendAvaliation({
    required AvaliationModel avaliation,
    required String requestedId,
  }) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.post,
        url: '${EndPoints.sendAvaliation}$requestedId',
        body: avaliation.toJson(),
      );

      if (result.isEmpty) {
        List<RequestModel> data = [];

        return RequestReceivedResult.success(data);
      } else {
        if (result['statusCode'] == 403) {
          return RequestReceivedResult.error("Você já enviou sua avaliação sobre este usuário!");
        } else {
          return RequestReceivedResult.error("Não foi possível enviar a avaliação!");
        }
      }
    } on Exception catch (e) {
      print(e);

      return RequestReceivedResult.error("Não foi possível enviar a avaliação!");
    }
  }

  Future<PaymentLinkResult> generatePaymentLink({
    required double value,
    required String description,
    required String serviceRequestID,
  }) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.post,
        url: '${EndPoints.generatePaymentLink}',
        body: {
          "value": value,
          "productDescription": description,
          "userServiceRequestId": serviceRequestID,
        },
      );

      if (result != null && result['paymentLink'] != null) {
        String data = result['paymentLink'];

        return PaymentLinkResult.success(data);
      } else {
        return PaymentLinkResult.error("Não foi possível gerar o link para pagamento!");
      }
    } on Exception {
      return PaymentLinkResult.error("Não foi possível gerar o link para pagamento!");
    }
  }

  Future<SendFileResult> deleteFile({required String idRequest, required String idFile}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.delete,
        url: '${EndPoints.deleteFileRequest}$idRequest/files/$idFile',
      );

      if (result['message'] != null) {
        //String data = result['paymentLink'];

        return SendFileResult.success('Arquivo removido com sucesso!');
      } else {
        return SendFileResult.error("Não foi possível remover o arquivo!");
      }
    } on Exception {
      return SendFileResult.error("Não foi possível remover o arquivo. Tente novamente mais tarde!");
    }
  }

  Future<DownloadFileRequestResult> downloadFile({
    required String url,
    required String savePath,
  }) async {
    // Obtém o diretório de armazenamento externo do dispositivo

    final result = await httpManager.downloadFile(url: url, savePath: savePath);

    if (result.statusCode == 200) {
      String data = 'Download finalizado!';
      return DownloadFileRequestResult.success(data);
    }
    String data = 'Erro ao realizar download!';
    return DownloadFileRequestResult.success(data);
  }

  Future<DownloadFileRequestResult> uploadFile({required List<File> files, required String requestId}) async {
    // FormData formData = FormData.fromMap({
    //   'file[]': await MultipartFile.fromFile(file, filename: file.split('/').last),
    //   // Adicione outros campos se necessário
    // });

    List<MultipartFile> multiPartFiles = [];

    // Iterar sobre a lista de arquivos e adicionar cada um ao FormData
    for (File file in files) {
      String fileName = file.path.split('/').last;
      multiPartFiles.add(await MultipartFile.fromFile(file.path, filename: fileName));
    }

    FormData formData = FormData.fromMap({
      'files[]': multiPartFiles,
      // Adicione outros campos se necessário
    });

    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.post,
        url: '${EndPoints.uploadFileRequest}$requestId/files',
        body: formData,
      );

      if (result['message'] != null) {
        return DownloadFileRequestResult.success(result['message']);
      } else {
        return DownloadFileRequestResult.error('Não foi possivel enviar o arquivo.');
      }
    } catch (e) {
      log('Erro ao enviar arquivo', error: e);
      return DownloadFileRequestResult.error('Tente novamente mais tarde.');
    }
  }
}
