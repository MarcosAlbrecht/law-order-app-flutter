import 'package:app_law_order/src/models/post_model.dart';
import 'package:app_law_order/src/pages/social/repository/social_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';

const int itemsPerPage = 10;

class PostController extends GetxController {
  final socialRepository = SocialRepository();
  final utilServices = UtilServices();
  List<PostModel>? currentListPost;

  List<PostModel> allPosts = [];

  bool isLoading = false;

  bool isSaving = false;

  int pagination = 0;

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
}
