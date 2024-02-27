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
                                Get.toNamed(PagesRoutes.mayWalletScreen);
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
                                final bool result = await showDeleteAccount(context);
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

Future<bool> showDeleteAccount(BuildContext context) async {
  final size = MediaQuery.sizeOf(context);
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0), // Ajuste de padding
            title: const Text('Tem certeza que deseja excluir sua conta?'),
            content: SizedBox(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),

                  //width: size.width * 0.2, // Defina a largura do conteúdo
                  child: const Text(
                    'Exclusão de Conta.\n\n'
                    'Prezado(a),\n\n'
                    'Por favor, esteja ciente dos seguintes pontos importantes para excluir sua conta.:\n\n'
                    '1. **Perda de Dados:** Ao prosseguir com a exclusão da sua conta, todos os dados associados a ela serão permanentemente removidos. Isso inclui histórico de compras, preferências de configuração, e quaisquer outros dados pessoais ou transacionais relacionados à sua conta.\n\n'
                    '2. **Saldo na Carteira:** Se houver algum saldo remanescente na sua carteira, este valor será perdido após a exclusão da conta. Recomendamos que você utilize qualquer saldo existente antes de prosseguir com a exclusão da conta.\n\n'
                    '3. **Implicações Futuras:** Após a exclusão da sua conta, você não poderá mais acessar ou utilizar os serviços com as credenciais desta conta e qualquer outro conteúdo vinculado à sua conta.\n\n'
                    'Por favor, tenha certeza de que deseja prosseguir com esta ação, pois ela é irreversível e não poderá ser desfeita. Se você tiver alguma dúvida ou preocupação, não hesite em entrar em contato conosco para obter assistência adicional.\n\n',
                    style: TextStyle(
                      fontSize: 12.0, // Tamanho da fonte
                      //fontWeight: FontWeight.normal, // Peso da fonte (normal, bold, etc.)
                      // Estilo da fonte (normal, itálico)
                      color: Colors.black, // Cor do texto
                      letterSpacing: 1.2, // Espaçamento entre as letras
                      height: 1.5, // Altura da linha (espaçamento entre linhas)
                    ),
                    textAlign: TextAlign.justify, // Alinhamento do texto
                    overflow: TextOverflow.visible, // Comportamento de overflow do texto
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back(); // Retorna falso para cancelar a exclusão
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.blueDark2Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Confirmar',
                  style: TextStyle(
                    color: CustomColors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          );
        },
      ) ??
      false; // Retorna falso por padrão se showDialog retornar nulo
}
