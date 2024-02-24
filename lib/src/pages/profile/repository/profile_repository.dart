import 'dart:io';

import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/follower_model.dart';
import 'package:app_law_order/src/models/follows_model.dart';
import 'package:app_law_order/src/models/notification_model.dart';
import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/home/result/follows_result.dart';
import 'package:app_law_order/src/pages/profile/result/follower_result.dart';
import 'package:app_law_order/src/pages/profile/result/notifications_result.dart';
import 'package:app_law_order/src/pages/profile/result/update_picture_profile_result.dart';
import 'package:app_law_order/src/pages/profile/result/user_service_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  final HttpManager httpManager = HttpManager();
  final utilServices = UtilServices();

  Future<UpdateProfilePictureResult> updateProfilePicture({required File picture}) async {
    // Criar um FormData para enviar a imagem
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(picture.path, filename: picture.path.split('/').last),
      // Adicione outros campos se necessário
    });

    final result = await httpManager.restRequest(
      method: HttpMethods.post,
      url: EndPoints.updateProfilePicture,
      body: formData,
    );

    if (result != null) {
      return UpdateProfilePictureResult.success(true);
    } else {
      return UpdateProfilePictureResult.error(false);
    }
  }

  Future<UpdateProfilePictureResult> insertPortfolioPicture({required String picture}) async {
    // Criar um FormData para enviar a imagem
    FormData formData = FormData.fromMap({
      'files[]': await MultipartFile.fromFile(picture, filename: picture.split('/').last),
      // Adicione outros campos se necessário
    });

    final result = await httpManager.restRequest(
      method: HttpMethods.post,
      url: EndPoints.insertPortfolioPicture,
      body: formData,
    );

    if (result.isEmpty) {
      return UpdateProfilePictureResult.success(true);
    } else {
      return UpdateProfilePictureResult.error(false);
    }
  }

  Future<UpdateProfilePictureResult> deletePortfolioPicture({required String idPicture}) async {
    // Criar um FormData para enviar a imagem

    final result = await httpManager.restRequest(
      method: HttpMethods.delete,
      url: '${EndPoints.deletePortfolioPicture}$idPicture',
    );

    if (result.isEmpty) {
      return UpdateProfilePictureResult.success(true);
    } else {
      return UpdateProfilePictureResult.error(false);
    }
  }

  Future<UserServiceResult> insertService({required ServiceModel service}) async {
    // Criar um FormData para enviar a imagem

    final result = await httpManager.restRequest(
      method: HttpMethods.post,
      url: EndPoints.setUserService,
      body: [
        service.toJson(),
      ],
    );

    if (result.isEmpty) {
      return UserServiceResult.success(true);
    } else {
      return UserServiceResult.error("Ocorreu um erro inesperado ao inserir o serviço!");
    }
  }

  Future<UserServiceResult> updateService({required ServiceModel service}) async {
    // Criar um FormData para enviar a imagem

    final result = await httpManager.restRequest(
      method: HttpMethods.put,
      url: '${EndPoints.updateUserService}${service.id}',
      body: service.toJson(),
    );

    if (result.isEmpty) {
      return UserServiceResult.success(true);
    } else {
      return UserServiceResult.error("Ocorreu um erro inesperado ao inserir o serviço!");
    }
  }

  Future<UserServiceResult> deleteService({required ServiceModel service}) async {
    // Criar um FormData para enviar a imagem

    final result = await httpManager.restRequest(
      method: HttpMethods.delete,
      url: '${EndPoints.deleteUserService}${service.id}',
    );

    if (result.isEmpty) {
      return UserServiceResult.success(true);
    } else {
      return UserServiceResult.error("Ocorreu um erro inesperado ao inserir o serviço!");
    }
  }

  Future<UserServiceResult> updateSkills({required UserModel user}) async {
    //String jsonSkill = jsonEncode(user.skills);
    final result = await httpManager.restRequest(
      method: HttpMethods.patch,
      url: '${EndPoints.updateUser}/${user.id!}',
      body: {
        "skills": user.skills,
      },
    );

    if (result['_id'] != null) {
      return UserServiceResult.success(true);
    } else {
      return UserServiceResult.error('Ocorreu um erro ao editar os dados. Tente novamente mais tarde!');
    }
  }

  Future<UserServiceResult> updateProfile({required UserModel user}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.patch,
      url: '${EndPoints.updateUser}/${user.id!}',
      body: {
        "portfolioTitle": user.portfolioTitle,
        "portfolioAbout": user.portfolioAbout,
      },
    );

    if (result['_id'] != null) {
      return UserServiceResult.success(true);
    } else {
      return UserServiceResult.error('Ocorreu um erro ao editar os dados. Tente novamente mais tarde!');
    }
  }

  Future<FollowsResult<FollowsModel>> getFollows({required int limit, required int skip}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: EndPoints.getFollows,
      queryParams: {
        'limit': limit,
        'skip': skip,
      },
    );

    if (result['result'] != null) {
      List<FollowsModel> data = (List<Map<String, dynamic>>.from(result['result'])).map(FollowsModel.fromJson).toList();

      return FollowsResult.success(data);
    } else {
      return FollowsResult.error("Não foram encontrado dados!");
    }
  }

  Future<FollowerResult<FollowerModel>> getFollowers({required int limit, required int skip}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: EndPoints.getFollowers,
      queryParams: {
        'limit': limit,
        'skip': skip,
      },
    );

    if (result['result'] != null) {
      List<FollowerModel> data = (List<Map<String, dynamic>>.from(result['result'])).map(FollowerModel.fromJson).toList();

      return FollowerResult.success(data);
    } else {
      return FollowerResult.error("Não foram encontrado dados!");
    }
  }

  Future<NotificationsResult<NotificationModel>> getNotifications({required int limit, required int skip}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: EndPoints.getNotifications,
      queryParams: {
        'limit': limit,
        'skip': skip,
      },
    );

    if (result['result'] != null) {
      List<NotificationModel> data = (List<Map<String, dynamic>>.from(result['result'])).map(NotificationModel.fromJson).toList();

      return NotificationsResult.success(data);
    } else {
      return NotificationsResult.error("Não foram encontrado notificações!");
    }
  }

  Future<NotificationsResult<NotificationModel>> updateNotification({required String notificationID}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.patch,
      url: '${EndPoints.updateNotification}$notificationID',
    );

    if (result.isEmpty) {
      List<NotificationModel> data = [];

      return NotificationsResult.success(data);
    } else {
      return NotificationsResult.error("Não foi possível atualizar a notificação!");
    }
  }
}
