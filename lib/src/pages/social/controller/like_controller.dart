import 'package:app_law_order/src/models/post_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/social/repository/social_repository.dart';
import 'package:app_law_order/src/pages/social/result/like_result.dart';
import 'package:get/get.dart';

class LikeController extends GetxController {
  final socialRepository = SocialRepository();
  final authController = Get.find<AuthController>();
  PostModel post;

  LikeController({
    required this.post,
  });

  bool isLikes = false;

  void setLikes(bool value) {
    isLikes = value;
    update();
  }

  Future<void> handleLike() async {
    setLikes(true);
    var index = post.likes!.indexWhere((item) => item.userId == authController.user.id);
    late final LikeResult result;
    if (index < 0) {
      result = await socialRepository.insertLike(postId: post.id!);
      result.when(
        success: (data) async {
          data.user = authController.user;
          post.likes?.add(data);
          setLikes(false);
        },
        error: (message) {
          setLikes(false);
        },
      );
    } else {
      result = await socialRepository.removeLike(postId: post.id!);
      result.when(
        success: (data) async {
          //var index = post.likes!.indexWhere((item) => item.id == authController.user.id);
          post.likes?.removeWhere((item) => item.userId == authController.user.id);
          setLikes(false);
        },
        error: (message) {
          setLikes(false);
        },
      );
    }
  }
}
