import 'dart:io';

import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/follower_model.dart';
import 'package:app_law_order/src/models/follows_model.dart';
import 'package:app_law_order/src/models/notification_model.dart';
import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/models/wallet_model.dart';
import 'package:app_law_order/src/models/withdraw_history_model.dart';
import 'package:app_law_order/src/pages/home/result/follows_result.dart';
import 'package:app_law_order/src/pages/profile/result/follower_result.dart';
import 'package:app_law_order/src/pages/profile/result/notifications_result.dart';
import 'package:app_law_order/src/pages/profile/result/pix_result.dart';
import 'package:app_law_order/src/pages/profile/result/update_picture_profile_result.dart';
import 'package:app_law_order/src/pages/profile/result/user_result.dart';
import 'package:app_law_order/src/pages/profile/result/user_service_result.dart';
import 'package:app_law_order/src/pages/profile/result/wallet_result.dart';
import 'package:app_law_order/src/pages/profile/result/withdraw_profile_result.dart';
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

  Future<UserResult> getUserById({required String id}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.get,
        url: '${EndPoints.getUserById}$id',
      );

      if (result['_id'] != null) {
        var userData = result as Map<String, dynamic>;
        UserModel data = UserModel.fromJson(userData);
        return UserResult.success(data);
      } else {
        return UserResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
      }
    } on Exception catch (e) {
      return UserResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
    }
  }

  Future<PixResult> createPix({required String key}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.post,
        url: EndPoints.userPix,
        body: {
          'active': true,
          'key': key,
        },
      );

      if (result.isEmpty) {
        return PixResult.success('Chave Pix cadastrada com sucesso!');
      } else {
        return PixResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
      }
    } on Exception {
      return PixResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
    }
  }

  Future<PixResult> updateActivePix({required String key}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.patch,
        url: '${EndPoints.userPix}$key',
        body: {
          'active': true,
        },
      );

      if (result['message'] != null) {
        return PixResult.success(result['message']);
      } else {
        return PixResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
      }
    } on Exception {
      return PixResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
    }
  }

  Future<PixResult> deletePix({required String key}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.delete,
        url: '${EndPoints.userPix}$key',
        queryParams: {
          'key': key,
        },
      );

      if (result.isEmpty) {
        return PixResult.success('Chave Pix removida com sucesso!');
      } else {
        return PixResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
      }
    } on Exception {
      return PixResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
    }
  }

  Future<WithdrawProfileResult<WithdrawHistoryModel>> getWithdraws() async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.get,
        url: EndPoints.getWithdraw,
      );

      if (result.isNotEmpty) {
        List<WithdrawHistoryModel> data = (List<Map<String, dynamic>>.from(result)).map(WithdrawHistoryModel.fromJson).toList();
        return WithdrawProfileResult.success(data);
      } else {
        return WithdrawProfileResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
      }
    } on Exception {
      return WithdrawProfileResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
    }
  }

  Future<WalletResult> getWallet() async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.get,
        url: EndPoints.getWallet,
      );

      if (result.isNotEmpty) {
        var userData = result as Map<String, dynamic>;
        WalletModel data = WalletModel.fromJson(userData);

        return WalletResult.success(data);
      } else {
        return WalletResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
      }
    } on Exception {
      return WalletResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
    }
  }

  Future<UserResult> deleteUser({required String id}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.delete,
        url: '${EndPoints.deleteUser}/$id',
      );

      if (result.isEmpty) {
        UserModel data = UserModel();

        return UserResult.success(data);
      } else {
        return UserResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
      }
    } on Exception {
      return UserResult.error('Ocorreu um erro ao buscar os dados. Tente novamente mais tarde!');
    }
  }
}
