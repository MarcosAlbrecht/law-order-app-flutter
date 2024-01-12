import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/requests/result/request_received_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';
import 'package:app_law_order/src/services/util_services.dart';

class RequestRepository {
  final HttpManager httpManager = HttpManager();
  final utilServices = UtilServices();

  Future<RequestReceivedResult<RequestModel>> getRequestsReceived(
      {required int limit, required int skip}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: EndPoints.getRequestsReceived,
      queryParams: {
        'limit': limit,
        'skip': skip,
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
}
