import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/profile/controller/profile_controller.dart';
import 'package:app_law_order/src/pages/profile/view/components/picture_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/camera_dialog.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informações Pessoais",
          style: TextStyle(color: CustomColors.black),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: CustomColors.white,
          ),
          child: GetBuilder<ProfileController>(
            builder: (controller) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        label: "Título do Perfil",
                        initialValue:
                            controller.authController.user.portfolioTitle,
                        onSaved: (value) {
                          controller.authController.user.portfolioTitle = value;
                        },
                      ),
                      CustomTextField(
                        label: "Sobre você",
                        minLines: 1,
                        maxLines: 5,
                        initialValue:
                            controller.authController.user.portfolioAbout,
                        onSaved: (value) {
                          controller.authController.user.portfolioAbout = value;
                        },
                      ),
                      SizedBox(
                        height: 180,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(right: 15, bottom: 15),
                          scrollDirection: Axis.horizontal,
                          itemCount: controller
                                      .authController.user.portfolioPictures !=
                                  null
                              ? controller.authController.user
                                      .portfolioPictures!.length +
                                  1
                              : 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return GestureDetector(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CameraDialog(
                                        isPortfolio: true,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 150,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: CustomColors.blueDarkColor,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: CustomColors.white,
                                    size: 40,
                                  ),
                                ),
                              );
                            } else {
                              final photo = controller.authController.user
                                  .portfolioPictures![index - 1];
                              if (photo != null ||
                                  photo.url != null ||
                                  photo.localPath != null) {
                                return PictureTile(
                                  picture: controller.authController.user
                                      .portfolioPictures![index - 1],
                                  index: index,
                                );
                              } else {
                                return const SizedBox
                                    .shrink(); // Retorna um container vazio caso a propriedade seja nula
                              }
                            }
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 5),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
