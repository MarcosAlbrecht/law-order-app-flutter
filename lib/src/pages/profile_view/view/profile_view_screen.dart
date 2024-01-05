import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/profile_view/controller/profile_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: TextStyle(color: CustomColors.black),
        ),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: GetBuilder<ProfileViewController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.isLoading,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Container(
              color: CustomColors.white,
              padding: const EdgeInsets.all(16),
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: controller.user.profilePicture != null
                            ? NetworkImage(controller.user.profilePicture!.url!)
                            : const AssetImage('assets/ICONPEOPLE.png')
                                as ImageProvider,
                      ),
                      VerticalDivider(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.user.firstName} ${controller.user.lastName}',
                              style: TextStyle(
                                  fontSize: CustomFontSizes.fontSize20,
                                  color: CustomColors.blueDark2Color,
                                  fontWeight: FontWeight.w600),
                            ),
                            Visibility(
                              visible: controller.user.portfolioTitle != null,
                              child: Text(
                                '${controller.user.portfolioTitle}',
                                style: TextStyle(
                                  fontSize: CustomFontSizes.fontSize14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
