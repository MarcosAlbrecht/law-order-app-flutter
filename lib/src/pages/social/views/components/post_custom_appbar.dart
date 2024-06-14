// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostCustomAppBar extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onPostPressed;
  final UserModel? user;
  final String logedUserId;

  const PostCustomAppBar({
    Key? key,
    this.onBackPressed,
    this.onPostPressed,
    this.user,
    required this.logedUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, right: 16),
      height: 80,
      width: double.infinity,
      color: CustomColors.blueDark2Color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    color: CustomColors.white,
                  ),
                  onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 8),
                buildProfileImage(),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Publicar"),
            ),
          )
        ],
      ),
    );
  }

  Widget buildProfileImage() {
    // Adicione sua lógica para a construção da imagem de perfil
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: user!.profilePicture != null
          ? CachedNetworkImage(
              imageUrl: user!.profilePicture!.url!,
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
            ),
    );
  }

  Widget buildNameAndPosition() {
    // Adicione sua lógica para a construção do nome e posição
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${user!.firstName} ${user!.lastName}',
            style: TextStyle(fontSize: 16, color: CustomColors.white, fontWeight: FontWeight.bold),
          ),
          user!.occupationArea != null
              ? Text(
                  user!.occupationArea != null ? '${user!.occupationArea} ' : '',
                  style: TextStyle(fontSize: 12, color: CustomColors.white),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
