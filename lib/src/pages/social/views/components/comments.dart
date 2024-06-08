// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/post_comment_model.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/social/controller/comments_controller.dart';
import 'package:app_law_order/src/pages/social/views/components/expandable_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class Comments extends StatefulWidget {
  final List<PostCommentModel> comments;
  const Comments({
    Key? key,
    required this.comments,
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
      child: Column(
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
                print("ver mais comentarios");
                _handleMoreComments(size, widget.comments);
              },
              child: Text(
                'Ver mais ${widget.comments.length.toString()} comentários',
                style: const TextStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleMoreComments(Size size, List<PostCommentModel> comments) {
    showModalBottomSheet<void>(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
            child: SizedBox(
              height: size.height * 0.75,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: CustomColors.blueDark2Color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<CommentsController>(
                      init: CommentsController(listComments: comments),
                      builder: (controller) {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  // Largura da imagem
                                  height: 50,
                                  width: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: comments[index].user?.profilePicture?.url != null
                                        ? CachedNetworkImage(
                                            imageUrl: comments[index].user!.profilePicture!.url!,
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
                                        '${comments[index].user!.firstName} ${comments[index].user!.lastName}',
                                        style: const TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      // Text(
                                      //   widget.comments[0].comment! + "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                                      //   style: const TextStyle(fontSize: 14),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                                        child: ExpandableText(
                                          fontSize14: true,
                                          paddingTop: false,
                                          text: comments[index].comment ?? '',
                                          maxLines: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: comments[index].userId == controller.authController.user.id,
                                  child: PopupMenuButton<int>(
                                    onSelected: (int item) {
                                      print(item.toString());
                                      print('Excluir comentário de índice: ${comments[index].id}');
                                    },
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                                      const PopupMenuItem<int>(
                                        value: 1,
                                        child: Text('Excluir'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: controller.listComments.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    height: 1,
                    //color: Colors.red,
                  ),
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            paddingBottom: false,
                            label: 'Adicione um comentário...',
                            removeFloatingLabelBehavior: true,
                            onChanged: (value) {
                              // Lógica para atualizar o texto do comentário
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 17, bottom: 17, left: 5),
                          child: SizedBox(
                            width: 60,
                            height: double.infinity,
                            child: Material(
                              color: CustomColors.blueDark2Color,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: IconButton(
                                color: CustomColors.white,
                                onPressed: () {
                                  // Lógica para enviar o comentário
                                },
                                icon: const Icon(Icons.send),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
