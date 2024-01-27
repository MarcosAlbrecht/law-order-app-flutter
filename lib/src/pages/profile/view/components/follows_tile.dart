// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/follows_model.dart';
import 'package:get/get.dart';

class FollowsTile extends StatelessWidget {
  final FollowsModel follow;
  const FollowsTile({
    Key? key,
    required this.follow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          PagesRoutes.profileViewScreen,
          arguments: {'idUser': follow.followed?.id},
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Material(
          elevation: 3,
          color: CustomColors.cyanColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(
              //   color: Colors.cyan.shade200,
              //   width: 1, // Defina a largura da borda conforme necessário
              // ),
              //color: CustomColors.backgroudCard,
            ),
            child: ListTile(
              visualDensity: VisualDensity.comfortable,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: follow.followed?.profilePicture != null
                    ? CachedNetworkImage(
                        imageUrl: follow.followed!.profilePicture!.url!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      )
                    : Image.asset(
                        "assets/ICONPEOPLE.png",
                        fit: BoxFit.cover,
                      ),
              ),
              title: Text(
                '${follow.followed!.firstName!} ${follow.followed!.lastName!}',
                style: TextStyle(fontSize: CustomFontSizes.fontSize16),
              ),
              subtitle: Text(
                '${follow.followed!.city!}, ${follow.followed!.state!}',
                style: TextStyle(fontSize: CustomFontSizes.fontSize14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
