import 'package:app_law_order/src/models/post_comment_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/social/repository/social_repository.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  final authController = Get.find<AuthController>();
  List<PostCommentModel> listComments;

  CommentsController({
    required this.listComments,
  });

  final socialRepository = SocialRepository();

  bool isExclude = false;

  void setExclude(bool value) {
    isExclude = value;
    update();
  }

  Future<void> handleExcludeComment({required String commentId}) async {
    setExclude(true);
  }
}
