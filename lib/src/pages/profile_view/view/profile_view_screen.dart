import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/profile_view/controller/profile_view_controller.dart';
import 'package:app_law_order/src/pages/profile_view/view/components/picture_tile.dart';
import 'package:app_law_order/src/pages/profile_view/view/components/services_tile.dart';
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
                          //container com foto e nome
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

                          //container com cidade
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

                          //container com area de atuaçao
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
                            height: 20,
                          ),

                          //container com as fotos do portfolio
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Trabalhos',
                                style: TextStyle(
                                    color: CustomColors.black,
                                    fontSize: CustomFontSizes.fontSize18),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Visibility(
                                  visible: controller.user.portfolioPictures !=
                                          null &&
                                      controller
                                          .user.portfolioPictures!.isNotEmpty,
                                  replacement: const Text('Não informado'),
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 5),
                                    height: 180,
                                    child: GridView.builder(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 16, 16),
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                                childAspectRatio: 9 / 8),
                                        itemBuilder: (context, index) {
                                          return PictureTile(
                                            picture: controller
                                                .user.portfolioPictures![index],
                                          );
                                        },
                                        // separatorBuilder: (context, index) =>
                                        //     const SizedBox(width: 5),
                                        itemCount:
                                            controller.user.portfolioPictures !=
                                                    null
                                                ? controller.user
                                                    .portfolioPictures!.length
                                                : 0),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            height: 30,
                          ),

                          //sontainer texto SOBRE
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sobre',
                                style: TextStyle(
                                    color: CustomColors.black,
                                    fontSize: CustomFontSizes.fontSize18),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Visibility(
                                  visible:
                                      controller.user.portfolioAbout != null &&
                                          controller
                                              .user.portfolioAbout!.isNotEmpty,
                                  replacement: const Text('Não informado'),
                                  child: Text(
                                    '${controller.user.portfolioAbout}',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      fontSize: CustomFontSizes.fontSize14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 30,
                              ),
                            ],
                          ),

                          //container com a lista de serviços
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Serviços',
                                style: TextStyle(
                                    color: CustomColors.black,
                                    fontSize: CustomFontSizes.fontSize18),
                              ),
                              Visibility(
                                visible: controller.user.services != null &&
                                    controller.user.services!.isNotEmpty,
                                replacement: const Text(
                                    'Nenhum serviço adicionado ainda.'),
                                child: Container(
                                  height: 180,
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ListView.separated(
                                    separatorBuilder: (_, context) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      return ServicesTile(
                                        //height: 100,
                                        //child: Text("OLA" + index.toString()),

                                        service:
                                            controller.user.services![index],
                                      );
                                    },
                                    itemCount: controller.user.services != null
                                        ? controller.user.services!.length
                                        : 0,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //container das avaliaçoes
                          const Divider(
                            height: 30,
                          ),

                          //container com as avaliaçoes
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Avaliações',
                                style: TextStyle(
                                    color: CustomColors.black,
                                    fontSize: CustomFontSizes.fontSize18),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Visibility(
                                  visible: false,
                                  replacement: const Text(
                                      'O Prestador ainda não recebeu avaliações'),
                                  child: Container(
                                    height: 180,
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ListView.separated(
                                      separatorBuilder: (_, context) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        return ServicesTile(
                                          //height: 100,
                                          //child: Text("OLA" + index.toString()),

                                          service:
                                              controller.user.services![index],
                                        );
                                      },
                                      itemCount:
                                          controller.user.services != null
                                              ? controller.user.services!.length
                                              : 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                                  Get.toNamed(PagesRoutes.serviceRequestScreen);
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
