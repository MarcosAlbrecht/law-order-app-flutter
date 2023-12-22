import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/home/result/all_users_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager httpManager = HttpManager();

  Future<AllUsersResult<UserModel>> getAllUsersPaginated(
      {required int limit, required int skip}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: EndPoints.getAllUsersPaginated,
      queryParams: {
        'limit': limit,
        'skip': skip,
      },
    );

    if (result['result'] != null) {
      List<UserModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map(UserModel.fromJson)
          .toList();

      return AllUsersResult.success(data);
    } else {
      return AllUsersResult.error("Não foi encontrado dados!");
    }
  }
}
