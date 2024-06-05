// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/post_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/social/views/components/comments.dart';
import 'package:app_law_order/src/pages/social/views/components/expandable_text.dart';
import 'package:app_law_order/src/pages/social/views/components/interactions_buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class PostTile extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final PostModel post;

  PostTile({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        //padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          //color: CustomColors.backGround.withOpacity(0.09),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  // Largura da imagem
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: post.owner!.profilePicture!.url!,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          SquareProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => const Icon(Icons.person),
                      fit: BoxFit.cover,
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
                              '${post.owner!.firstName?.trim()} ${post.owner!.lastName!.trim()}',
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
                        timePassedSince(post.createdAt ?? ''),
                      ),
                    ],
                  ),
                )
              ],
            ),
            ExpandableText(
              text: post.description ?? '',
              maxLines: 10,
            ),
            post.photos!.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: StaggeredGrid.count(
                      crossAxisCount: post.photos!.isNotEmpty
                          ? post.photos!.length <= 4
                              ? post.photos!.length
                              : 4
                          : 0,
                      mainAxisSpacing: post.photos!.length > 4 ? 4 : post.photos!.length.toDouble(),
                      crossAxisSpacing: post.photos!.length > 4 ? 4 : post.photos!.length.toDouble(),
                      children: _buildPhotoTiles(),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 5,
            ),
            InteractionsButtons(liked: post.likes!.any((element) => element.userId == authController.user.id)),
            post.comments!.isNotEmpty
                ? Comments(
                    comments: post.comments!,
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPhotoTiles() {
    List<Widget> tiles = [];
    //
    var count = 0;
    for (var photo in post.photos!) {
      print(count.toString());
      if (count > 4) {
        break;
      }
      tiles.add(
        StaggeredGridTile.count(
          crossAxisCellCount: count == 0
              ? post.photos!.length > 4
                  ? 4
                  : post.photos!.length
              : 1,
          mainAxisCellCount: count == 0
              ? post.photos!.length > 4
                  ? 4
                  : post.photos!.length
              : 1,
          child: count == 4
              ? Container(
                  //margin: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: photo.url!,
                          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.contain,
                        ),
                        Container(
                          color: Colors.black54, // Cor preta semi-transparente
                        ),
                        Center(
                          child: Text(
                            '+${(post.photos!.length - count).toString()}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  // Largura da imagem
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: photo.url!,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          SquareProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: post.photos?.length == 1 ? BoxFit.cover : BoxFit.cover,
                    ),
                  ),
                ),
        ),
      );
      count++;
    }
    return tiles;
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
      return 'há ${difference.inDays} dia';
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
}
