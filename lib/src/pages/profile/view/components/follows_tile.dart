// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
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
          elevation: 5,
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
              leading: CircleAvatar(
                backgroundImage: follow.followed?.profilePicture != null
                    ? NetworkImage(follow.followed!.profilePicture!.url!)
                    : const AssetImage("assets/ICONPEOPLE.png")
                        as ImageProvider<Object>,
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
