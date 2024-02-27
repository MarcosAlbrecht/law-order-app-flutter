// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatTile extends StatelessWidget {
  final ChatModel chat;
  final String logedUserId;
  const ChatTile({
    Key? key,
    required this.chat,
    required this.logedUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          PagesRoutes.chatMessageScreen,
          arguments: {'chat_model': chat},
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Material(
          //elevation: 3,
          color: CustomColors.white,
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(
          //     bottomLeft: Radius.circular(10),
          //     bottomRight: Radius.circular(10),
          //     topLeft: Radius.circular(10),
          //     topRight: Radius.circular(10),
          //   ),
          // ),
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
              visualDensity: VisualDensity.compact,
              dense: true,
              //contentPadding: EdgeInsets.all(0),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: logedUserId == chat.destinationUserId
                      ? chat.user?.profilePicture != null
                          ? CachedNetworkImage(
                              imageUrl: chat.user!.profilePicture!.url!,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                            )
                          : Image.asset(
                              "assets/ICONPEOPLE.png",
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                            )
                      : CachedNetworkImage(
                          imageUrl: chat.destinationUser!.profilePicture!.url!,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        )),
              title: logedUserId == chat.destinationUserId
                  ? Text(
                      '${chat.user!.firstName!} ${chat.user!.lastName!}',
                      style: TextStyle(fontSize: CustomFontSizes.fontSize14),
                    )
                  : Text(
                      '${chat.destinationUser!.firstName!} ${chat.destinationUser!.lastName!}',
                      style: TextStyle(fontSize: CustomFontSizes.fontSize14),
                    ),
              subtitle: Text(
                chat.message != null ? '${chat.message}' : '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: CustomFontSizes.fontSize12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
