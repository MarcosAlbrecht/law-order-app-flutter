import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/profile_view/result/profile_view_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';
import 'package:app_law_order/src/services/util_services.dart';

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
      return ProfileViewResult.error(
          'Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
    }
  }
}
