import 'dart:convert';

import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile_view/result/profile_view_result.dart';
import 'package:app_law_order/src/pages/profile_view/result/service_request_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';

class ProfileViewRepository {
  final HttpManager httpManager = HttpManager();
  final utilServices = UtilServices();

  Future<ProfileViewResult> getUserById({required String id}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: '${EndPoints.getUserById}$id',
    );

    if (result['_id'] != null) {
      var userData = result as Map<String, dynamic>;
      UserModel data = UserModel.fromJson(userData);
      return ProfileViewResult.success(data);
    } else {
      if (result['errorCode'] != null && result['errorCode'] == 33) {
        final auth = Get.find<AuthController>();
        auth.logout();
      }
      return ProfileViewResult.error(
          'Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
    }
  }

  Future<ServiceRequestResult> insertServiceRequest({
    required String userRequestedId,
    required List<String> requestedServiceIds,
  }) async {
    String jsonList = jsonEncode(requestedServiceIds);
    final result = await httpManager.restRequest(
      method: HttpMethods.post,
      url: '${EndPoints.setServiceRequest}$userRequestedId',
      body: {
        "requestedServiceIds": jsonList,
      },
    );

    if (result.isEmpty) {
      return ServiceRequestResult.success(true);
    } else {
      return ServiceRequestResult.error(
          "Não foi possível enviar a solicitação!");
    }
  }
}
