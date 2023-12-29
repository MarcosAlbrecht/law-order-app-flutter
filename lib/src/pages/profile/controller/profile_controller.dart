import 'dart:io';
import 'dart:typed_data';

import 'package:app_law_order/src/models/picture_model.dart';
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

  final authController = Get.find<AuthController>();

  final UtilServices utilService = UtilServices();

  final ImagePicker imagePicker = ImagePicker();

  late Uint8List imageBytes;
  late File file;
  late PictureModel profilePinctureUrl;

  bool isLoading = false;
  bool isSaving = false;
  bool isSavingPicuture = false;

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

  Future<void> handleUpdateProfile() async {
    setSaving(value: true);

    //fazer umload da imagem primeiro
    if (isSavingPicuture) {
      final result =
          await profileRepository.updateProfilePicture(picture: file);
      result.when(
        success: (data) {},
        error: (message) {
          utilService.showToast(
              message: "Ocorreu um erro ao fazer o upload da imagem!",
              isError: true);
        },
      );
    }
    await authController.handleProfileEdit();
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
      preferredCameraDevice: CameraDevice.front,
    );
    if (image != null) {
      if (!isPortfolio) {
        //comprime a imagem
        file = File(image.path);
        file = await compressFile(file);

        isSavingPicuture = true;
        String filePath = file.path;

        imageBytes = await File(filePath).readAsBytes();

        //seta pra null a profilePicture pra poder atualizar na scrren
        if (authController.user.profilePicture != null) {
          profilePinctureUrl = authController.user.profilePicture!;
          authController.user.profilePicture = null;
        }
      } else {
        PictureModel portfolioPincture = PictureModel();
        portfolioPincture.status = "insert";
        portfolioPincture.localPath = image.path;
        authController.user.portfolioPictures?.add(portfolioPincture);
      }

      update();
    }
  }

  Future<void> addPhotoFromGallery({bool isPortfolio = false}) async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (!isPortfolio) {
        file = File(image.path);
        file = await compressFile(file);

        isSavingPicuture = true;

        String filePath = file.path;

        imageBytes = await File(filePath).readAsBytes();

        //seta pra null a profilePicture pra poder atualizar na scrren
        if (authController.user.profilePicture != null) {
          profilePinctureUrl = authController.user.profilePicture!;
          authController.user.profilePicture = null;
        }
      }

      update();
    }
  }
}
