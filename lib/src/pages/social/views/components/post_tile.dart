// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/post_model.dart';
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
    return Column(
      children: [
        Row(
          children: [
            Container(
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
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        StaggeredGrid.count(
          crossAxisCount: post.photos != null
              ? post.photos!.length <= 4
                  ? post.photos!.length
                  : 4
              : 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: _buildPhotoTiles(),

          // StaggeredGridTile.count(
          //   crossAxisCellCount: 6,
          //   mainAxisCellCount: 4,
          //   child: Container(
          //     // Largura da imagem
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(5),
          //       child: CachedNetworkImage(
          //         imageUrl: post.photos![0].url!,
          //         progressIndicatorBuilder: (context, url, downloadProgress) =>
          //             SquareProgressIndicator(value: downloadProgress.progress),
          //         errorWidget: (context, url, error) => const Icon(Icons.error),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          // StaggeredGridTile.count(
          //   crossAxisCellCount: 2,
          //   mainAxisCellCount: 1,
          //   child: Container(color: Colors.black54, child: const Center(child: Text('1'))),
          // ),
          // StaggeredGridTile.count(
          //   crossAxisCellCount: 1,
          //   mainAxisCellCount: 1,
          //   child: Container(
          //     color: Colors.black54,
          //     child: const Center(
          //       child: Text('2'),
          //     ),
          //   ),
          // ),
          // StaggeredGridTile.count(
          //   crossAxisCellCount: 1,
          //   mainAxisCellCount: 1,
          //   child: Container(color: Colors.black54, child: const Center(child: Text('3'))),
          // ),
        ),
      ],
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
          crossAxisCellCount: count == 0 ? 4 : 1,
          mainAxisCellCount: count == 0 ? 4 : 1,
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
                          fit: BoxFit.cover,
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
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
      );
      count++;
    }
    return tiles;
  }
}
