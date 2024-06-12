import 'package:app_law_order/src/models/post_comment_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
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
  bool isInsertingComment = false;

  void setExclude(bool value) {
    isExclude = value;
    update();
  }

  void setInsertingComment(bool value) {
    isInsertingComment = value;
    update();
  }

  Future<void> handleExcludeComment({required String commentId}) async {
    setExclude(true);
    final result = await socialRepository.removeComment(commentId: commentId);

    setExclude(false);
    result.when(
      success: (data) {
        setExclude(true);
        listComments.removeAt(listComments.indexWhere((item) => item.id == commentId));
        setExclude(false);
      },
      error: (message) {},
    );
  }

  Future<UserModel?> getUserById({required String id}) async {
    UserModel? retorno = null;
    final result = await socialRepository.getUserById(userId: id);
    result.when(
      success: (data) {
        retorno = data;
      },
      error: (message) {},
    );

    return retorno;
  }

  Future<void> handleInsertComment({required String postId, comment}) async {
    setInsertingComment(true);
    final result = await socialRepository.insertComment(comment: comment, postId: postId);

    result.when(
      success: (data) async {
        final res = await getUserById(id: data.userId!);
        if (res != null) {
          data.user = res;
          listComments.add(data);
        }

        setInsertingComment(false);
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
        setInsertingComment(false);
      },
    );
  }
}
