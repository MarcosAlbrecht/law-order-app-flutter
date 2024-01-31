// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/pages/profile/controller/notification_controller.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:get/get.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/notification_model.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  NotificationTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            controller.handleReadNotification(notification: notification);
            //Get.toNamed(
            //  PagesRoutes.profileViewScreen,
            //arguments: {'idUser': follow.followed?.id},
            //);
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
                  color: !notification.read!
                      ? CustomColors.backgroudCard
                      : CustomColors.white,
                ),
                child: ListTile(
                  visualDensity: VisualDensity.comfortable,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: !notification.read!
                        ? Icon(Octicons.mail)
                        : Icon(Octicons.mail_read),
                  ),
                  title: Text(
                    '${notification.message}',
                    style: TextStyle(fontSize: CustomFontSizes.fontSize14),
                  ),
                  subtitle: Text(
                    utilServices.formatDateTime(notification.createdAt),
                    style: TextStyle(fontSize: CustomFontSizes.fontSize12),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
