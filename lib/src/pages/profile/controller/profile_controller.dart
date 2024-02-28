import 'dart:io';
import 'dart:typed_data';

import 'package:app_law_order/src/models/picture_model.dart';
import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile/repository/profile_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileController extends GetxController {
  final profileRepository = ProfileRepository();

  UserModel userModel = UserModel();
  ServiceModel actualService = ServiceModel();

  final authController = Get.find<AuthController>();

  final UtilServices utilService = UtilServices();

  final ImagePicker imagePicker = ImagePicker();

  Uint8List imageBytes = Uint8List(0);
  late File file;
  late PictureModel profilePinctureUrl;
  late String skill;

  bool isLoading = false;
  bool isSaving = false;
  bool isSavingPicuture = false;
  bool isSavingPortfolioPicuture = false;
  bool isSavingService = false;
  bool isSavingSkill = false;

  @override
  void onInit() {
    super.onInit();
  }

  void setLoading({required bool value}) {
    isLoading = value;

    update();
  }

  void setSaving({required bool value}) {
    isSaving = value;

    update();
  }

  void setSavingPortfolioPicuture({required bool value}) {
    isSaving = value;

    update();
  }

  void setSavingService({required bool value}) {
    isSaving = value;

    update();
  }

  void setSavingSkill({required bool value}) {
    isSaving = value;

    update();
  }

  Future<void> handleUpdateProfile() async {
    setSaving(value: true);

    //fazer umload da imagem primeiro
    if (isSavingPicuture) {
      final result = await profileRepository.updateProfilePicture(picture: file);
      result.when(
        success: (data) {},
        error: (message) {
          utilService.showToast(message: "Ocorreu um erro ao fazer o upload da imagem!", isError: true);
        },
      );
    }
    await authController.handleProfileEdit(validaCep: false);
    setSaving(value: false);
    isSavingPicuture = false;
  }

  Future<File> compressFile(File file) async {
    try {
      final result = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        minWidth: 1920,
        minHeight: 1080,
        quality: 90,
      );
      String fileName = file.path.split('/').last;
      final tempDir = await getTemporaryDirectory();
      final tempPath = tempDir.path;
      final tempFile = File('$tempPath/compressed_$fileName');

      await tempFile.writeAsBytes(result!.toList());

      return tempFile;
    } catch (e) {
      print(e);
      return File("");
    }
  }

  Future<void> addPhotoFromCamera({bool isPortfolio = false}) async {
    final image = await imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: isPortfolio ? CameraDevice.rear : CameraDevice.front,
    );
    if (image != null) {
      //comprime a imagem
      file = File(image.path);
      file = await compressFile(file);

      isSavingPicuture = true;
      String filePath = file.path;

      imageBytes = await File(filePath).readAsBytes();

      if (!isPortfolio) {
        //seta pra null a profilePicture pra poder atualizar na scrren
        if (authController.user.profilePicture != null) {
          profilePinctureUrl = authController.user.profilePicture!;
          authController.user.profilePicture = null;
        }
      } else {
        //verifica se inseriu a imagem com sucesso no banco
        if (await inertImagePortfolio(imagePath: file.path)) {
          // PictureModel portfolioPincture = PictureModel();
          // portfolioPincture.status = "insert";
          // portfolioPincture.localPath = file.path;
          // authController.user.portfolioPictures?.add(portfolioPincture);
        }
      }
    }
    update();
  }

  Future<void> addPhotoFromGallery({bool isPortfolio = false}) async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      file = File(image.path);
      file = await compressFile(file);

      isSavingPicuture = true;

      String filePath = file.path;

      imageBytes = await File(filePath).readAsBytes();

      //seta pra null a profilePicture pra poder atualizar na scrren
      if (!isPortfolio) {
        if (authController.user.profilePicture != null) {
          profilePinctureUrl = authController.user.profilePicture!;
          authController.user.profilePicture = null;
        }
      } else {
        //verifica se inseri a imagem com sucesso no banco
        if (await inertImagePortfolio(imagePath: file.path)) {
          // PictureModel portfolioPincture = PictureModel();
          // portfolioPincture.status = "insert";
          // portfolioPincture.localPath = file.path;
          // authController.user.portfolioPictures?.add(portfolioPincture);
        }
      }
    }
    update();
  }

  Future<bool> inertImagePortfolio({required String imagePath}) async {
    bool success = false;
    setSavingPortfolioPicuture(value: true);
    final result = await profileRepository.insertPortfolioPicture(picture: imagePath);

    await result.when(
      success: (data) async {
        //recaregar informaçoes do usuário;
        await authController.getUserById();
        success = true;
        utilService.showToast(message: "Foto adicionada com sucesso!");
      },
      error: (data) {
        utilService.showToast(message: "Oocrreu um erro a adicionar a imagem!", isError: true);
        success = false;
      },
    );

    setSavingPortfolioPicuture(value: false);
    return success;
  }

  Future<void> deleteImagePortfolio({required PictureModel picture, required int index}) async {
    setSavingPortfolioPicuture(value: true);
    final result = await profileRepository.deletePortfolioPicture(idPicture: picture.id!);
    result.when(success: (data) {
      authController.user.portfolioPictures?.removeWhere((item) => item.id == picture.id);

      utilService.showToast(message: "Foto removida com sucesso!");
    }, error: (data) {
      utilService.showToast(message: "Não foi possível remover a foto!", isError: true);
    });

    setSavingPortfolioPicuture(value: false);
  }

  Future<void> handleService({
    required String status,
  }) async {
    setSavingService(value: true);
    switch (status) {
      case 'insert':
        final result = await profileRepository.insertService(service: actualService);
        await result.when(
          success: (data) async {
            await authController.getUserById();
            utilService.showToast(message: "Serviço adicionado com sucesso!");
          },
          error: (message) {
            utilService.showToast(message: message, isError: true);
          },
        );
        break;
      case 'edit':
        final result = await profileRepository.updateService(service: actualService);
        result.when(
          success: (data) {
            for (var element in authController.user.services!) {
              element.id == actualService.id;
              element = actualService;
              utilService.showToast(message: "Serviço atualizado com sucesso!");
              break;
            }
          },
          error: (message) {
            utilService.showToast(message: message, isError: true);
          },
        );
        break;
      case 'delete':
        final result = await profileRepository.deleteService(service: actualService);
        result.when(
          success: (data) async {
            authController.user.services?.removeWhere((element) => element.id == actualService.id);
            utilService.showToast(message: "Serviço removido com sucesso!");
          },
          error: (message) {
            utilService.showToast(message: message, isError: true);
          },
        );
        break;
      default:
    }
    setSavingService(value: false);
  }

  Future<void> handleSkill({required String status}) async {
    setSavingSkill(value: true);
    switch (status) {
      case 'insert':
        authController.user.skills?.add(skill);
        final result = await profileRepository.updateSkills(user: authController.user);
        result.when(
          success: (data) {
            utilService.showToast(message: "Competência adicionada com sucesso!");
          },
          error: (message) {
            utilService.showToast(message: message, isError: true);
            authController.user.skills?.removeWhere((element) => element == skill);
          },
        );

        break;
      case 'delete':
        authController.user.skills?.removeWhere((element) => element == skill);
        final result = await profileRepository.updateSkills(user: authController.user);
        result.when(
          success: (data) {
            utilService.showToast(message: "Competência removida com sucesso!");
          },
          error: (message) {
            utilService.showToast(message: message, isError: true);
            authController.user.skills?.removeWhere((element) => element == skill);
          },
        );

      default:
    }
    skill = "";
    setSavingSkill(value: false);
  }

  Future<void> handleDeleteAccount() async {
    final result = await profileRepository.deleteUser(id: authController.user.id!);
    result.when(success: (data) {
      authController.logout();
    }, error: (message) {
      utilService.showToast(message: message, isError: true);
    });
  }
}
