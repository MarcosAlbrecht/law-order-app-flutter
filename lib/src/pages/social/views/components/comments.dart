// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/post_comment_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // Largura da imagem
                height: 30,
                width: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: widget.comments[0].user!.profilePicture!.url!,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        SquareProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
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
                      style: TextStyle(fontWeight: FontWeight.w600),
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
            visible: widget.comments.length > 0,
            child: GestureDetector(
              onTap: () {
                print("ver mais comentarios");
                _handleMoreComments(size);
              },
              child: Text(
                'Ver mais ${widget.comments.length.toString()} comentários',
                style: TextStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleMoreComments(Size size) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => SizedBox(
        height: size.height * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              dense: true,
              leading: const Icon(Icons.photo),
              title: const Text('Foto'),
              onTap: () {
                Navigator.pop(context);
                //_handleImageSelection(controller);
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Arquivo  '),
              onTap: () {
                Navigator.pop(context);
                //_handleFileSelection(controller);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancelar'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
