import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/profile_view/controller/profile_view_controller.dart';
import 'package:app_law_order/src/pages/profile_view/view/components/picture_tile.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //foto do user
                              Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 3,
                                        color: CustomColors.blueColor,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          controller.user.profilePicture != null
                                              ? NetworkImage(controller
                                                  .user.profilePicture!.url!)
                                              : const AssetImage(
                                                      'assets/ICONPEOPLE.png')
                                                  as ImageProvider,
                                    ),
                                  ),
                                  Positioned(
                                    left: 15,
                                    right: 15,
                                    bottom: 0,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: CustomColors.blueDark2Color,
                                            shape: BoxShape.rectangle),
                                        child: Center(
                                          child: Text(
                                            "Prestador",
                                            style: TextStyle(
                                                color: CustomColors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    CustomFontSizes.fontSize12),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              const VerticalDivider(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        '${controller.user.firstName} ${controller.user.lastName}',
                                        style: TextStyle(
                                            fontSize:
                                                CustomFontSizes.fontSize24,
                                            color: CustomColors.blueDark2Color,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Visibility(
                                      visible: controller.user.portfolioTitle !=
                                          null,
                                      child: Text(
                                        '${controller.user.portfolioTitle}',
                                        style: TextStyle(
                                            fontSize:
                                                CustomFontSizes.fontSize14,
                                            color: Colors.grey.shade600),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.place_outlined,
                                  size: 16,
                                  color: CustomColors.blueDark2Color,
                                ),
                                const VerticalDivider(
                                  width: 10,
                                  color: Colors.transparent,
                                ),
                                Expanded(
                                  child: Text(
                                    '${controller.user.city}, ${controller.user.state}',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      fontSize: CustomFontSizes.fontSize14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.work_outline_outlined,
                                  size: 16,
                                  color: CustomColors.blueDark2Color,
                                ),
                                const VerticalDivider(
                                  width: 10,
                                  color: Colors.transparent,
                                ),
                                Expanded(
                                  child: Text(
                                    '${controller.user.occupationArea}',
                                    style: TextStyle(
                                      fontSize: CustomFontSizes.fontSize14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trabalhos',
                                    style: TextStyle(
                                        color: CustomColors.black,
                                        fontSize: CustomFontSizes.fontSize18),
                                  ),
                                  Visibility(
                                    visible:
                                        controller.user.portfolioPictures !=
                                            null,
                                    child: Container(
                                      height: 160,
                                      child: ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padding: const EdgeInsets.only(
                                              right: 15, bottom: 15),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return PictureTile(
                                              picture: controller.user
                                                  .portfolioPictures![index],
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(width: 5),
                                          itemCount: controller
                                                      .user.portfolioPictures !=
                                                  null
                                              ? controller.user
                                                  .portfolioPictures!.length
                                              : 0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: GetBuilder<ProfileViewController>(
                      builder: (authController) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.blueDark2Color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: authController.isLoading
                              ? null
                              : () {
                                  Get.toNamed(PagesRoutes.signUpStep1);
                                },
                          child: authController.isLoading
                              ? CircularProgressIndicator(
                                  color: CustomColors.black,
                                )
                              : Text(
                                  'Solicitar serviço',
                                  style: TextStyle(
                                    color: CustomColors.white,
                                    fontSize: 18,
                                  ),
                                ),
                        );
                      },
                    ),
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
