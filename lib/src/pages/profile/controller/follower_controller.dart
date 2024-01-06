import 'package:app_law_order/src/models/follower_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile/repository/profile_repository.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:get/get.dart';

const int itemsPerPage = 10;

class FollowerController extends GetxController {
  final profileRepository = ProfileRepository();

  final authController = Get.find<AuthController>();

  List<FollowerModel>? currentListFollower;
  List<FollowerModel> follower = [];

  bool isLoading = false;

  int pagination = 0;

  bool get isLastPage {
    if (currentListFollower!.length < itemsPerPage) return true;

    var follower;
    return pagination + itemsPerPage > follower.length;
  }

  @override
  void onInit() {
    super.onInit();

    loadFollowers();
  }

  void setLoading(bool value, {bool isUser = false}) {
    if (isUser) {
      isLoading = value;
    }
    update();
  }

  void loadMoreFollowers() {
    pagination = pagination + 10;
    loadFollowers(canLoad: false);
  }

  Future<void> loadFollowers({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isUser: true);
    }

    final result = await profileRepository.getFollowers(
        limit: itemsPerPage, skip: pagination);

    setLoading(false, isUser: true);

    result.when(
      success: (data) {
        currentListFollower = data;
        follower.addAll(currentListFollower!);
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
  }
}
