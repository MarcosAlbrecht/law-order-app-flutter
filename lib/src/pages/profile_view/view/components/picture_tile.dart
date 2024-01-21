// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:app_law_order/src/models/picture_model.dart';
import 'package:app_law_order/src/pages/profile_view/view/components/picture_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PictureTile extends StatelessWidget {
  final PictureModel picture;
  const PictureTile({
    Key? key,
    required this.picture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        width: 180,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // image: DecorationImage(
          //   image: picture.url != null
          //       ? NetworkImage(picture.url!) as ImageProvider<Object>
          //       : FileImage(File(picture.localPath!)),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: picture.url != null
            ? CachedNetworkImage(
                imageUrl: picture.url!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                //height: 160,
                //width: 160,
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
