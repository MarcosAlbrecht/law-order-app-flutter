// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:app_law_order/src/models/picture_model.dart';
import 'package:app_law_order/src/pages/profile_view/view/components/picture_dialog.dart';
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
          image: DecorationImage(
            image: picture.url != null
                ? NetworkImage(picture.url!) as ImageProvider<Object>
                : FileImage(File(picture.localPath!)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
