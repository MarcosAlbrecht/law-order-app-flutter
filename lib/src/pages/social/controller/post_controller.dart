import 'dart:io';

import 'package:app_law_order/src/models/post_model.dart';
import 'package:app_law_order/src/pages/social/repository/social_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

const int itemsPerPage = 10;

class PostController extends GetxController {
  final socialRepository = SocialRepository();
  final utilServices = UtilServices();
  List<PostModel>? currentListPost;
  List<String> listUploadedImages = [];
  List<String> listUploadedVideos = [];
  String postDescription = '';
  final videoExtensions = ['mp4', 'mov', 'wmv', 'avi', 'mkv'];

  List<PostModel> allPosts = [];

  bool isLoading = false;

  bool isSaving = false;

  bool isLoadingFiles = false;

  int pagination = 0;

  List<File> files = [];

  bool get isLastPage {
    if (currentListPost!.length < itemsPerPage) return true;

    return pagination + itemsPerPage > allPosts.length;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    loadPosts(canLoad: true);
  }

  void setLoading(bool value, {bool isUser = false}) {
    if (isUser) {
      isLoading = value;
    }
    update();
  }

  void setLoadingFiles(bool value) {
    isLoadingFiles = value;

    update();
  }

  void setSaving(bool value) {
    isSaving = value;

    update();
  }

  void loadMorePosts() {
    pagination = pagination + 10;
    loadPosts(canLoad: false);
  }

  Future<void> loadPosts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isUser: true);
    }
    var result = await socialRepository.getPostsPaginated(limit: itemsPerPage, skip: pagination);

    setLoading(false, isUser: true);

    result.when(
      success: (data) {
        currentListPost = data;
        allPosts.addAll(currentListPost!);
      },
      error: (message) {
        utilServices.showToast(message: message);
      },
    );
  }

  Future<void> imagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      onFileLoading: (p0) {
        setLoadingFiles(true);
      },
    );

    if (result != null) {
      files = files + result.paths.map((path) => File(path!)).toList();

      if (files.length > 1) {}
      //handleUploadFile(files: files, idRequest: idRequest);
    }
    setLoadingFiles(false);

    //update();
  }

  Future<void> videoPicker() async {
    setLoadingFiles(true);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
      onFileLoading: (p0) {
        setLoadingFiles(true);
      },
    );
    setLoadingFiles(false);

    if (result != null) {
      files = files + result.paths.map((path) => File(path!)).toList();

      if (files.length > 1) {}
      //handleUploadFile(files: files, idRequest: idRequest);
    }
  }

  Future<File> _correctImageOrientation(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes)!;
    final orientedImage = img.bakeOrientation(image);
    final orientedBytes = img.encodeJpg(orientedImage);

    final orientedFile = File('${file.path}_oriented.jpg');
    await orientedFile.writeAsBytes(orientedBytes);

    return orientedFile;
  }

  bool _isVideoFile(String path) {
    final videoExtensions = ['mp4', 'mov', 'wmv', 'avi', 'mkv'];
    final fileExtension = path.split('.').last.toLowerCase();
    return videoExtensions.contains(fileExtension);
  }

  Future<void> removeFile({required String filePath}) async {
    files.removeWhere((item) => item.path == filePath);
    update();
  }

  Future<void> uploadFiles() async {
    for (var file in files) {
      final result = await socialRepository.insertFile(picture: file.path);
      result.when(
          success: (data) {
            if (_isVideoFile(file.path)) {
              listUploadedVideos?.add(data.id!);
            } else {
              listUploadedImages?.add(data.id!);
            }
          },
          error: (message) {});
    }
  }

  Future<void> cretePost({required String description}) async {
    setSaving(true);
    if (files.length > 0) {
      await uploadFiles();
    }

    final result = await socialRepository.insertPost(
        description: description, photosIds: listUploadedImages ?? [], videosIds: listUploadedVideos ?? []);
  }
}
