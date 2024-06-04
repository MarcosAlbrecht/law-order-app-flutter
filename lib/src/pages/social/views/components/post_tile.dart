// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/post_model.dart';
import 'package:app_law_order/src/pages/social/views/components/expandable_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class PostTile extends StatelessWidget {
  final PostModel post;

  const PostTile({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CustomColors.backGround.withAlpha(110),
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
                      errorWidget: (context, url, error) => const Icon(Icons.error),
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
                          Text(
                            post.owner!.firstName?.trim() ?? '',
                            style: TextStyle(
                              color: CustomColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' ${post.owner!.lastName!.trim()}',
                            style: TextStyle(
                              color: CustomColors.black,
                              fontWeight: FontWeight.bold,
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
            const SizedBox(
              height: 15,
            ),
            ExpandableText(
              text: post.description ?? '',
              maxLines: 10,
            ),
            const SizedBox(
              height: 15,
            ),
            post.photos!.isNotEmpty
                ? StaggeredGrid.count(
                    crossAxisCount: post.photos!.isNotEmpty
                        ? post.photos!.length <= 4
                            ? post.photos!.length
                            : 4
                        : 0,
                    mainAxisSpacing: post.photos!.length > 4 ? 4 : post.photos!.length.toDouble(),
                    crossAxisSpacing: post.photos!.length > 4 ? 4 : post.photos!.length.toDouble(),
                    children: _buildPhotoTiles(),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 15,
            ),
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
                      fit: post.photos?.length == 1 ? BoxFit.contain : BoxFit.cover,
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
