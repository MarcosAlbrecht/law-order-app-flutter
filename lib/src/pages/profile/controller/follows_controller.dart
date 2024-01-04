import 'package:app_law_order/src/models/follows_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile/repository/profile_repository.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:get/get.dart';

const int itemsPerPage = 10;

class FollowsController extends GetxController {
  final profileRepository = ProfileRepository();

  final authController = Get.find<AuthController>();

  List<FollowsModel>? currentListFollows;
  List<FollowsModel> follows = [];

  bool isLoading = false;

  int pagination = 0;

  bool get isLastPage {
    if (currentListFollows!.length < itemsPerPage) return true;

    return pagination * itemsPerPage > follows.length;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loadFollows();
  }

  void setLoading(bool value, {bool isUser = false}) {
    if (isUser) {
      isLoading = value;
    }
    update();
  }

  void loadMoreFollows() {
    pagination = pagination + 10;
    loadFollows(canLoad: false);
  }

  Future<void> loadFollows({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isUser: true);
    }

    final result = await profileRepository.getFollows(
        limit: itemsPerPage, skip: pagination);

    setLoading(false, isUser: true);

    result.when(
      success: (data) {
        currentListFollows = data;
        follows.addAll(currentListFollows!);
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
  }
}
