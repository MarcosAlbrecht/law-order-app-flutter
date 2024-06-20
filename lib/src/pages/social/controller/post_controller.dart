import 'dart:io';

import 'package:app_law_order/src/models/picture_model.dart';
import 'package:app_law_order/src/models/post_model.dart';
import 'package:app_law_order/src/pages/social/repository/social_repository.dart';
import 'package:app_law_order/src/pages/social/result/create_post_result.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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

  PostModel? postEdit;

  bool isLoading = false;

  bool isSaving = false;

  bool isLoadingFiles = false;

  bool isEditing = false;

  int pagination = 0;

  String descricaoPost = '';

  List<PictureModel> files = [];

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

  Future<void> refreshPosts() async {
    pagination = 0;
    allPosts = [];
    currentListPost = [];
    loadPosts(canLoad: true);
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
    setLoadingFiles(true);

    final ImagePicker _imagePicker = ImagePicker();
    final image = await _imagePicker.pickMultiImage();
    if (image != null) {
      for (var pickedFile in image) {
        File file = File(pickedFile.path);
        file = await testCompressFile(file);

        //cria e adiciona uma lista de FileModel
        PictureModel fileModel = PictureModel();
        fileModel.localPath = file.path;
        files.add(fileModel);
      }
    }
    setLoadingFiles(false);
  }

  Future<File> testCompressFile(File file) async {
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      rotate: 0,
      quality: 100,
    );
    String fileName = file.path.split('/').last;
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final tempFile = File('$tempPath/compressed_$fileName');

    await tempFile.writeAsBytes(result!.toList());

    return tempFile;
  }

  Future<void> videoPicker() async {
    setLoadingFiles(true);

    final ImagePicker _videoPicker = ImagePicker();
    final video = await _videoPicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      File file = File(video.path);
      file = await testCompressFile(file);

      //cria e adiciona uma lista de FileModel
      PictureModel fileModel = PictureModel();
      fileModel.localPath = file.path;
      files.add(fileModel);
    }
    setLoadingFiles(false);
  }

  bool _isVideoFile(String path) {
    final videoExtensions = ['mp4', 'mov', 'wmv', 'avi', 'mkv'];
    final fileExtension = path.split('.').last.toLowerCase();
    return videoExtensions.contains(fileExtension);
  }

  Future<void> removeFile({required String filePath}) async {
    files.removeWhere((item) => item.localPath == filePath || item.url == filePath);
    update();
  }

  Future<void> uploadFiles() async {
    for (var file in files) {
      if (file.localPath != null) {
        final result = await socialRepository.insertFile(picture: file.localPath!);
        result.when(
          success: (data) {
            if (_isVideoFile(file.localPath!)) {
              listUploadedVideos.add(data.id!);
            } else {
              listUploadedImages.add(data.id!);
            }
          },
          error: (message) {},
        );
      } else if (file.url != null) {
        if (_isVideoFile(file.url!)) {
          listUploadedVideos.add(file.id!);
        } else {
          listUploadedImages.add(file.id!);
        }
      }
    }
  }

  Future<void> handleEditInsertPost() async {
    setSaving(true);
    if (files.length > 0) {
      await uploadFiles();
    }

    late CreatePostResult result;
    if (isEditing) {
      result = await socialRepository.editPost(
        description: descricaoPost,
        photosIds: listUploadedImages,
        videosIds: listUploadedVideos,
        idPost: postEdit!.id!,
      );
    } else {
      result = await socialRepository.insertPost(
        description: descricaoPost,
        photosIds: listUploadedImages,
        videosIds: listUploadedVideos,
      );
    }

    result.when(
      success: (data) async {
        pagination = 0;
        currentListPost = [];
        allPosts = [];
        files = [];

        await loadPosts();
        if (isEditing) {
          utilServices.showToast(message: "Post editado com sucesso!", isError: false);
        } else {
          utilServices.showToast(message: "Post adicionado com sucesso!", isError: false);
        }

        setSaving(false);
      },
      error: (message) {
        utilServices.showToast(message: "Não foi possível adicionar o post. Teste novamente mais tarde!", isError: true);
        setSaving(false);
      },
    );

    isEditing = false;
  }

  Future<void> deletePost({required String postId}) async {
    setSaving(true);
    // if (files.length > 0) {
    //   await uploadFiles();
    // }

    final result = await socialRepository.removePost(postId: postId);
    setSaving(false);
    result.when(
      success: (data) {
        allPosts.removeWhere((item) => item.id == postId);
        utilServices.showToast(message: "Post removido com sucesso!", isError: false);
      },
      error: (message) {
        utilServices.showToast(message: "Não foi possível remover o post. Teste novamente mais tarde!", isError: true);
      },
    );
  }

  Future<void> handleEditPost({required String postId}) async {
    setLoadingFiles(true);
    isEditing = true;
    files = [];
    postEdit = allPosts.firstWhereOrNull((item) => item.id == postId)!;
    if (postEdit != null) {
      descricaoPost = postEdit?.description ?? '';
      files.addAll(postEdit!.photos!);
      files.addAll(postEdit!.videos!);

      files.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    }
    setLoadingFiles(false);
  }

  Future<void> handleNewtPost() async {
    setLoadingFiles(true);
    isEditing = true;
    files = [];

    setLoadingFiles(false);
  }
}
