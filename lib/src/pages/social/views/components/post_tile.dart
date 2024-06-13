// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/picture_model.dart';
import 'package:app_law_order/src/models/post_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/social/controller/like_controller.dart';
import 'package:app_law_order/src/pages/social/views/components/comments.dart';
import 'package:app_law_order/src/pages/social/views/components/comments_modal.dart';
import 'package:app_law_order/src/pages/social/views/components/expandable_text.dart';
import 'package:app_law_order/src/pages/social/views/components/interactions_buttons.dart';
import 'package:app_law_order/src/pages/social/views/components/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class PostTile extends StatefulWidget {
  final PostModel post;

  PostTile({
    super.key,
    required this.post,
  });

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  final authController = Get.find<AuthController>();

  String reason = '';

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
    });
  }

  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        //padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: CustomColors.backGround.withOpacity(0.4),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: [
                  SizedBox(
                    // Largura da imagem
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      child: widget.post.owner?.profilePicture?.url != null
                          ? CachedNetworkImage(
                              imageUrl: widget.post.owner!.profilePicture!.url!,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
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
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${widget.post.owner!.firstName?.trim()} ${widget.post.owner!.lastName!.trim()}',
                                style: TextStyle(
                                  color: CustomColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          timePassedSince(widget.post.createdAt ?? ''),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: ExpandableText(
                text: widget.post.description ?? '',
                maxLines: 10,
              ),
            ),
            widget.post.photos!.isNotEmpty
                ? SizedBox(
                    height: size.height * 0.6,
                    width: size.width,
                    child: CarouselSlider(
                      items: createImageSliders(widget.post.photos!, size),
                      carouselController: _controller,
                      options: CarouselOptions(
                          scrollPhysics:
                              widget.post.photos!.length > 1 ? const PageScrollPhysics() : const NeverScrollableScrollPhysics(),
                          height: size.height * 0.6,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  )
                : widget.post.videos!.isNotEmpty
                    ? VideoPlayerWidget(
                        videoUrl: widget.post.videos![0].url!,
                      )
                    : const SizedBox.shrink(),
            Visibility(
              visible: widget.post.photos!.length > 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.post.photos!.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 6.0,
                      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GetBuilder<LikeController>(
              init: LikeController(post: widget.post),
              global: false,
              builder: (controller) {
                return InteractionsButtons(
                  liked: controller.post.likes!.any((element) => element.userId == authController.user.id),
                  onCommentPressed: () {
                    showModalBottomSheet<void>(
                      useSafeArea: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return CommentModalWidget(
                          postId: widget.post.id!,
                          size: size,
                          comments: widget.post.comments!,
                        );
                      },
                    );
                  },
                  onLikePressed: () {
                    controller.handleLike();
                  },
                );
              },
            ),
            widget.post.comments!.isNotEmpty
                ? Comments(
                    postId: widget.post.id!,
                    comments: widget.post.comments!,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  String timePassedSince(String dateString) {
    // ignore: prefer_is_empty
    if (dateString.length < 0) return '';
    // Parse the input date string to a DateTime object
    DateTime inputDate = DateTime.parse(dateString);

    // Get the current date and time
    DateTime now = DateTime.now();

    // Calculate the difference between the current date and the input date
    Duration difference = now.difference(inputDate);

    // Check if the difference is more than 24 hours (1 day)
    if (difference.inDays > 0 && difference.inDays <= 1) {
      return 'há um dia';
    } else if (difference.inDays > 1) {
      return 'há ${difference.inDays} dias';
    } else {
      if (difference.inHours > 0 && difference.inHours <= 1) {
        return 'há ${difference.inHours} hora';
      } else {
        return 'há ${difference.inHours} horas';
      }
    }
  }

  List<Widget> createImageSliders(List<PictureModel> pictureList, Size size) {
    return pictureList.map((item) {
      return Container(
        margin: const EdgeInsets.all(5.0),
        child: Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: item.url!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SquareProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  height: size.height,
                  width: size.width,
                ),
                Visibility(
                  visible: pictureList.length > 1,
                  child: Positioned(
                    top: 1.0,
                    right: 1.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(
                          colors: [Color.fromARGB(198, 0, 0, 0), Color.fromARGB(0, 41, 41, 41)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                      child: Text(
                        '${pictureList.indexOf(item) + 1}/${pictureList.length.toString()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
