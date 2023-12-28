// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/user_model.dart';
import 'package:get/get.dart';

import 'package:app_law_order/src/models/follows_model.dart';
import 'package:app_law_order/src/pages/home/controller/home_controller.dart';

class FollowController extends GetxController {
  UserModel user;

  FollowController({
    required this.user,
  });

  final homeController = Get.find<HomeController>();

  late FollowsModel? followed;

  bool isFollowing = false;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await getFollow();
  }

  void setFollowing(bool value) {
    isFollowing = value;
    update();
  }

  Future<FollowsModel?> getFollow() async {
    followed = homeController.follows
        .firstWhereOrNull((element) => element.followedId == user.id);

    return followed;
  }

  Future<void> handleFollow() async {
    setFollowing(true);

    await homeController.handleFollow(follow: followed, user: user);
    await getFollow();

    setFollowing(true);
  }
}
