// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/profile/controller/profile_controller.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        color: CustomColors.white,
        child: GetBuilder<ProfileController>(
          builder: (controller) {
            return Column(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 10),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: CustomColors.blueColor,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: controller.authController.user.profilePicture != null
                                    ? CachedNetworkImage(
                                        imageUrl: controller.authController.user.profilePicture!.url!,
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            CircularProgressIndicator(value: downloadProgress.progress),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                        height: 160,
                                        width: 160,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/ICONPEOPLE.png",
                                        height: 160,
                                        width: 160,
                                      ),
                              ),
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
                              color: CustomColors.blueDark2Color,
                              fontWeight: FontWeight.bold,
                              fontSize: CustomFontSizes.fontSize22),
                        ),
                        const Divider(
                          height: 5,
                          color: Colors.transparent,
                        ),
                        Text(
                          '${controller.authController.user.email}',
                          style: TextStyle(color: CustomColors.black.withAlpha(100), fontSize: CustomFontSizes.fontSize18),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OptionInfo(
                              text: " Minha Carteira",
                              icon: Icons.wallet_outlined,
                              onTap: () {
                                //Get.toNamed(PagesRoutes.profileScreen);
                              },
                            ),
                            const Divider(
                              height: 5,
                              color: Colors.transparent,
                            ),
                            OptionInfo(
                              text: " Saques",
                              icon: Icons.attach_money,
                              onTap: () {
                                Get.toNamed(PagesRoutes.withdrawScreen);
                              },
                            ),
                            const Divider(
                              height: 5,
                              color: Colors.transparent,
                            ),
                            OptionInfo(
                              text: " Informações Pessoais",
                              icon: Icons.settings,
                              onTap: () {
                                Get.toNamed(PagesRoutes.profileScreen);
                              },
                            ),
                            const Divider(
                              height: 5,
                              color: Colors.transparent,
                            ),
                            OptionInfo(
                              text: " Portfólio",
                              icon: Icons.person_2_outlined,
                              onTap: () {
                                Get.toNamed(PagesRoutes.portfolioScreen);
                              },
                            ),
                            const Divider(
                              height: 5,
                              color: Colors.transparent,
                            ),
                            OptionInfo(
                              text: " Notificações",
                              icon: Icons.notifications_outlined,
                              onTap: () {
                                Get.toNamed(PagesRoutes.notificationsScreen);
                              },
                            ),
                            const Divider(
                              height: 5,
                              color: Colors.transparent,
                            ),
                            OptionInfo(
                              text: " Seguidores",
                              icon: Icons.people_alt_outlined,
                              onTap: () {
                                Get.toNamed(PagesRoutes.followerScreen);
                              },
                            ),
                            const Divider(
                              height: 5,
                              color: Colors.transparent,
                            ),
                            OptionInfo(
                              text: " Seguindo",
                              icon: Icons.people_alt_outlined,
                              onTap: () {
                                Get.toNamed(PagesRoutes.followsScreen);
                              },
                            ),
                            const Divider(
                              height: 5,
                              color: Colors.transparent,
                            ),
                            OptionInfo(
                              text: " Sair",
                              icon: Icons.power_settings_new_outlined,
                              onTap: () async {
                                final bool result = await showLogoutfirmation(context);
                                if (result) {
                                  controller.authController.logout();
                                }
                              },
                            ),
                            const Divider(
                              height: 5,
                              color: Colors.transparent,
                            ),
                            OptionInfo(
                              text: " Excluir Conta",
                              icon: Icons.delete_forever_outlined,
                              onTap: () async {
                                final bool result = await showLogoutfirmation(context);
                                if (result) {
                                  controller.authController.logout();
                                }
                              },
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

class OptionInfo extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onTap;
  const OptionInfo({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColors.backgroudCard,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: CustomColors.blueDark2Color,
                ),
                const VerticalDivider(
                  width: 10,
                  color: Colors.transparent,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: CustomFontSizes.fontSize16),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: CustomColors.blueDark2Color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> showLogoutfirmation(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sair'),
            content: const Text('Tem certeza que deseja deslogar do aplicativo?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Retorna falso para cancelar a exclusão
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Retorna verdadeiro para confirmar a exclusão
                },
                child: const Text('Confirmar'),
              ),
            ],
          );
        },
      ) ??
      false; // Retorna falso por padrão se showDialog retornar nulo
}
