// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/profile/controller/profile_controller.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        color: CustomColors.blueDark2Color,
        child: GetBuilder<ProfileController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  color: CustomColors.blueDark2Color,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: CustomColors.white,
                              ),
                            ),
                            child:
                                controller.authController.user.profilePicture !=
                                        null
                                    ? Image.network(
                                        controller.authController.user
                                            .profilePicture!.url!,
                                        height: 140,
                                        width: 140,
                                      )
                                    : Image.asset(
                                        "assets/ICONPEOPLE.png",
                                        height: 140,
                                        width: 140,
                                      ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 5,
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: CustomColors.white,
                                    shape: BoxShape.circle),
                                child: Icon(Icons.mode_edit_outline_rounded)),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                        color: Colors.transparent,
                      ),
                      Text(
                        '${controller.authController.user.firstName} ${controller.authController.user.lastName}',
                        style: TextStyle(
                            color: CustomColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: CustomFontSizes.fontSize20),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            const optionInfo(
                                text: " Informações Pessoais",
                                icon: Icons.settings),
                            const Divider(
                              height: 5,
                              color: Colors.transparent,
                            ),
                            const optionInfo(
                                text: " Portfólio",
                                icon: Icons.person_2_outlined),
                            Divider(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.cyanColor,
                              ),
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.settings,
                                        color: CustomColors.blueColor,
                                      ),
                                      Text(
                                        " Notificações",
                                        style: TextStyle(
                                            fontSize:
                                                CustomFontSizes.fontSize18),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.cyan,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.cyanColor,
                              ),
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.settings,
                                        color: CustomColors.blueColor,
                                      ),
                                      Text(
                                        " Informações Pessoais",
                                        style: TextStyle(
                                            fontSize:
                                                CustomFontSizes.fontSize18),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.cyan,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.cyanColor,
                              ),
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.settings,
                                        color: CustomColors.blueColor,
                                      ),
                                      Text(
                                        " Informações Pessoais",
                                        style: TextStyle(
                                            fontSize:
                                                CustomFontSizes.fontSize18),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.cyan,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.cyanColor,
                              ),
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.settings,
                                        color: CustomColors.blueColor,
                                      ),
                                      Text(
                                        " Informações Pessoais",
                                        style: TextStyle(
                                            fontSize:
                                                CustomFontSizes.fontSize18),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.cyan,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class optionInfo extends StatelessWidget {
  final String text;
  final IconData icon;
  const optionInfo({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColors.cyanColor,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: CustomColors.blueColor,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: CustomFontSizes.fontSize18),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.cyan,
            ),
          ],
        ),
      ),
    );
  }
}
