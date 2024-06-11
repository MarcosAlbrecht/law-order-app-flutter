import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/post_comment_model.dart';
import 'package:app_law_order/src/models/post_model.dart';
import 'package:app_law_order/src/pages/social/result/comment_result.dart';
import 'package:app_law_order/src/pages/social/result/post_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';
import 'package:app_law_order/src/services/util_services.dart';

class SocialRepository {
  final HttpManager httpManager = HttpManager();
  final utilServices = UtilServices();

  Future<PostResult<PostModel>> getPostsPaginated({required int limit, required int skip, String sortDirection = 'DESC'}) async {
    try {
      final Map<String, dynamic> queryParams = {
        'limit': limit,
        'skip': skip,
      };

      final result = await httpManager.restRequest(
        method: HttpMethods.get,
        url: EndPoints.getPostsPaginated,
        queryParams: queryParams,
      );

      if (result['result'].isNotEmpty) {
        List<PostModel> data = (List<Map<String, dynamic>>.from(result['result'])).map(PostModel.fromJson).toList();
        return PostResult.success(data);
      } else {
        if (result['result'] != null) {
          List<PostModel> data = [];
          return PostResult.success(data);
        } else {
          return PostResult.error("Não foi possível buscar os dados!");
        }
      }
    } on Exception {
      return PostResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<CommentResult> insertComment({required String comment}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.post,
        url: EndPoints.insertComment,
        body: {
          "comment": comment,
        },
      );

      if (result.isNotEmpty && result['_id'].isNotNull) {
        PostCommentModel data = PostCommentModel();
        return CommentResult.success(data);
      } else {
        if (result['result'] != null) {
          PostCommentModel data = PostCommentModel();
          return CommentResult.success(data);
        } else {
          return CommentResult.error("Não foi possível buscar os dados!");
        }
      }
    } on Exception {
      return CommentResult.error("Não foi possível buscar os dados!");
    }
  }

  Future<CommentResult> removeComment({required String commentId}) async {
    try {
      var request = '${EndPoints.removeComment}$commentId';
      final result = await httpManager.restRequest(
        method: HttpMethods.delete,
        url: '${EndPoints.removeComment}$commentId',
      );

      if (result.isEmpty) {
        PostCommentModel data = PostCommentModel();
        return CommentResult.success(data);
      } else {
        if (result['result'] != null) {
          PostCommentModel data = PostCommentModel();
          return CommentResult.success(data);
        } else {
          return CommentResult.error("Não foi possível buscar os dados!");
        }
      }
    } on Exception {
      return CommentResult.error("Não foi possível buscar os dados!");
    }
  }
}
