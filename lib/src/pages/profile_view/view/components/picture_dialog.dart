// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PictureDialog extends StatelessWidget {
  final String imageUrl;
  const PictureDialog({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      child: Stack(
        //fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.contain,
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
