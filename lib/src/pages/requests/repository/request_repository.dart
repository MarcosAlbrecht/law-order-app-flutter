import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/requests/result/acceptance_request_result.dart';
import 'package:app_law_order/src/pages/requests/result/payment_link_result.dart';
import 'package:app_law_order/src/pages/requests/result/request_received_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';
import 'package:app_law_order/src/services/util_services.dart';

class RequestRepository {
  final HttpManager httpManager = HttpManager();
  final utilServices = UtilServices();

  Future<RequestReceivedResult<RequestModel>> getRequestsReceived(
      {required int limit,
      required int skip,
      String sortDirection = 'DESC'}) async {
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
      List<RequestModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(RequestModel.fromJson)
              .toList();

      return RequestReceivedResult.success(data);
    } else {
      if (result['result'] != null) {
        List<RequestModel> data = [];
        return RequestReceivedResult.success(data);
      } else {
        return RequestReceivedResult.error("Não foi possível buscar os dados!");
      }
    }
  }

  Future<RequestReceivedResult<RequestModel>> getMyRequest(
      {required int limit,
      required int skip,
      String sortDirection = 'ASC'}) async {
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
      List<RequestModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(RequestModel.fromJson)
              .toList();

      return RequestReceivedResult.success(data);
    } else {
      return RequestReceivedResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<AcceptanceRequestResult> acceptProviderRequest(
      {required String dataDeadline, required String idRequest}) async {
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
  }

  Future<AcceptanceRequestResult> getServiceRequestByID(
      {required String idRequest}) async {
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
  }

  Future<RequestReceivedResult<RequestModel>> declineBudget({
    required int idRequest,
  }) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.patch,
      url: '${EndPoints.declineBudget} ',
    );

    if (result['result'].isNotEmpty) {
      List<RequestModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(RequestModel.fromJson)
              .toList();

      return RequestReceivedResult.success(data);
    } else {
      return RequestReceivedResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<RequestReceivedResult<RequestModel>> openContest({
    required String idRequest,
  }) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.patch,
      url: '${EndPoints.openContest} $idRequest',
    );

    if (result['statusCode'] == null) {
      List<RequestModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(RequestModel.fromJson)
              .toList();

      return RequestReceivedResult.success(data);
    } else {
      if (result['statusCode'] == 500) {
        return RequestReceivedResult.error(
            "Erro interno, tente novamente mais tarde!");
      } else {
        return RequestReceivedResult.error("Não foi possível buscar os dados!");
      }
    }
  }

  Future<RequestReceivedResult<RequestModel>> completeService({
    required String idRequest,
  }) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.patch,
      url: '${EndPoints.completeService}$idRequest',
    );

    if (result['statusCode'] == null) {
      List<RequestModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(RequestModel.fromJson)
              .toList();

      return RequestReceivedResult.success(data);
    } else {
      if (result['statusCode'] == 500) {
        return RequestReceivedResult.error(
            "Erro interno, tente novamente mais tarde!");
      } else {
        return RequestReceivedResult.error("Não foi possível buscar os dados!");
      }
    }
  }

  Future<RequestReceivedResult<RequestModel>> cancelRequest({
    required String idRequest,
  }) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.patch,
      url: '${EndPoints.cancelRequest}$idRequest',
    );

    if (result.isEmpty) {
      List<RequestModel> data = [];

      return RequestReceivedResult.success(data);
    } else {
      if (result['statusCode'] == 500) {
        return RequestReceivedResult.error(
            "Erro interno, tente novamente mais tarde!");
      } else {
        return RequestReceivedResult.error("Não foi possível buscar os dados!");
      }
    }
  }

  Future<PaymentLinkResult> generatePaymentLink({
    required double value,
    required String description,
    required String serviceRequestID,
  }) async {
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
      return PaymentLinkResult.error(
          "Não foi possível gerar o link para pagamento!");
    }
  }
}
