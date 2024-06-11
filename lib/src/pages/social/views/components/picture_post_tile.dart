// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/picture_model.dart';
import 'package:app_law_order/src/pages/profile_view/view/components/picture_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class PicturePostTile extends StatelessWidget {
  final PictureModel picture;
  const PicturePostTile({
    Key? key,
    required this.picture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (_) {
            return PictureDialog(imageUrl: picture.url!);
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 2),
        width: size.width * .85,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: picture.url != null
            ? CachedNetworkImage(
                imageUrl: picture.url!,
                progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SquareProgressIndicator(
                    height: 100,
                    width: 120,
                    borderRadius: 2,
                    value: downloadProgress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              )
            : Image.asset(
                "assets/ICONPEOPLE.png",
                height: 160,
                width: 160,
              ),
      ),
    );
  }
}
