// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/models/follower_model.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/follows_model.dart';
import 'package:get/get.dart';

class FollowerTile extends StatelessWidget {
  final FollowerModel follower;
  const FollowerTile({
    Key? key,
    required this.follower,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          PagesRoutes.profileViewScreen,
          arguments: {'idUser': follower.follower?.id},
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
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
                child: follower.follower?.profilePicture != null
                    ? CachedNetworkImage(
                        imageUrl: follower.follower!.profilePicture!.url!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/ICONPEOPLE.png",
                        fit: BoxFit.cover,
                      ),
              ),
              title: Text(
                '${follower.follower!.firstName!} ${follower.follower!.lastName!}',
                style: TextStyle(fontSize: CustomFontSizes.fontSize16),
              ),
              subtitle: Text(
                '${follower.follower!.city!}, ${follower.follower!.state!}',
                style: TextStyle(fontSize: CustomFontSizes.fontSize14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
