// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/post_comment_model.dart';
import 'package:app_law_order/src/pages/social/controller/comments_controller.dart';
import 'package:app_law_order/src/pages/social/views/components/comments_modal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class Comments extends StatefulWidget {
  final List<PostCommentModel> comments;
  final String postId;
  const Comments({
    Key? key,
    required this.comments,
    required this.postId,
  }) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: GetBuilder<CommentsController>(
        init: CommentsController(listComments: widget.comments),
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: widget.comments[0].user?.profilePicture?.url != null
                          ? CachedNetworkImage(
                              imageUrl: widget.comments[0].user!.profilePicture!.url!,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  SquareProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/ICONPEOPLE.png",
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.comments[0].user!.firstName} ${widget.comments[0].user!.lastName}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.comments[0].comment!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible: widget.comments.isNotEmpty,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      useSafeArea: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return CommentModalWidget(
                          postId: widget.postId,
                          size: size,
                          comments: widget.comments,
                          controller: controller,
                        );
                      },
                    );
                  },
                  child: Text(
                    'Ver mais ${widget.comments.length.toString()} comentários',
                    style: const TextStyle(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
