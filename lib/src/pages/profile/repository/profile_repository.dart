import 'dart:ffi';
import 'dart:io';

import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/profile/result/update_picture_profile_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  final HttpManager httpManager = HttpManager();
  final utilServices = UtilServices();

  Future<UpdateProfilePictureResult> updateProfilePicture(
      {required File picture}) async {
    // Criar um FormData para enviar a imagem
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(picture.path,
          filename: picture.path.split('/').last),
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

  Future<UpdateProfilePictureResult> insertPortfolioPicture(
      {required String picture}) async {
    // Criar um FormData para enviar a imagem
    FormData formData = FormData.fromMap({
      'files[]': await MultipartFile.fromFile(picture,
          filename: picture.split('/').last),
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

  Future<UpdateProfilePictureResult> deletePortfolioPicture(
      {required String idPicture}) async {
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
}
