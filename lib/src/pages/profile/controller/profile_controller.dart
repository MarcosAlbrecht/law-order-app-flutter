import 'dart:io';
import 'dart:typed_data';

import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileController extends GetxController {
  UserModel userModel = UserModel();

  final authController = Get.find<AuthController>();

  final UtilServices utilService = UtilServices();

  final ImagePicker imagePicker = ImagePicker();

  Uint8List imageBytes = Uint8List(0);

  bool isLoading = false;
  bool isSaving = false;

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
    await authController.handleProfileEdit();
    setSaving(value: false);
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

  Future<void> addPhotoFromCamera() async {
    final image = await imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    if (image != null) {
      File file = File(image.path);
      file = await compressFile(file);
      String fileName = file.path.split('/').last;
      String filePath = file.path;
      final sizeBytes = await file.length();

      imageBytes = await File(filePath).readAsBytes();

      // Converter os bytes da imagem em uma string base64
      //String base64Image = base64Encode(imageBytes);
      //user.picture = base64Image;

      //salvar imagem na api
      // final result = await authRepository.updatePictureUser(user: user);
      // result.when(
      //     success: (data) {},
      //     error: (message) {
      //       utilServices.showToast(message: message);
      //     });
      update();
    }
  }

  Future<void> addPhotoFromGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
  }
}
