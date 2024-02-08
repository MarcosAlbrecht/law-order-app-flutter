import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/follows_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/home/result/all_users_result.dart';
import 'package:app_law_order/src/pages/home/result/city_result.dart';
import 'package:app_law_order/src/pages/home/result/follows_result.dart';
import 'package:app_law_order/src/pages/home/result/state_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager httpManager = HttpManager();

  Future<AllUsersResult<UserModel>> getAllUsersPaginated(
      {required int limit, required int skip, List<Map<String, dynamic>> filters = const []}) async {
    // Converter a lista de filtros em uma lista de strings
    // Construir a lista de parâmetros da consulta
    final Map<String, dynamic> queryParams = {
      'limit': limit,
      'skip': skip,
    };

    for (var item in filters) {
      queryParams[item.keys.first] = item.values.first;
    }

    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: EndPoints.getAllUsersPaginated,
      queryParams: queryParams,
    );

    if (result['result'] != null) {
      List<UserModel> data = (List<Map<String, dynamic>>.from(result['result'])).map(UserModel.fromJson).toList();

      return AllUsersResult.success(data);
    } else {
      return AllUsersResult.error("Não foi encontrado dados!");
    }
  }

  Future<FollowsResult<FollowsModel>> getFollows() async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: EndPoints.getFollows,
      queryParams: {
        'limit': 99999999999,
        'skip': 0,
      },
    );

    if (result['result'] != null) {
      List<FollowsModel> data = (List<Map<String, dynamic>>.from(result['result'])).map(FollowsModel.fromJson).toList();

      return FollowsResult.success(data);
    } else {
      return FollowsResult.error("Não foi encontrado dados!");
    }
  }

  Future<FollowsResult<FollowsModel>> setFollow({required String userId}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.post,
      url: '${EndPoints.setFollow}$userId',
    );

    if (result.isEmpty) {
      List<FollowsModel> data = [];

      return FollowsResult.success(data);
    } else {
      return FollowsResult.error("Não foi encontrado dados!");
    }
  }

  Future<FollowsResult<FollowsModel>> setUnFollow({required String userId}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.delete,
      url: '${EndPoints.setUnFollow}$userId',
    );

    if (result.isEmpty) {
      List<FollowsModel> data = [];

      return FollowsResult.success(data);
    } else if (result['statusCode'] == 403) {
      return FollowsResult.error("Já curtiu este usuário");
    } else {
      return FollowsResult.error("Ocorreu um erro inesperado");
    }
  }

  Future<StateResult<String>> getStates() async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: EndPoints.getStates,
    );

    if (result.isNotEmpty) {
      List<String> data = List<String>.from(result);

      return StateResult.success(data);
    } else if (result['statusCode'] == 403) {
      return StateResult.error("Já curtiu este usuário");
    } else {
      return StateResult.error("Ocorreu um erro inesperado");
    }
  }

  Future<CityResult<String>> getCities() async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: EndPoints.getCities,
    );

    if (result.isNotEmpty) {
      List<String> data = List<String>.from(result);

      return CityResult.success(data);
    } else if (result['statusCode'] == 403) {
      return CityResult.error("Já curtiu este usuário");
    } else {
      return CityResult.error("Ocorreu um erro inesperado");
    }
  }
}
