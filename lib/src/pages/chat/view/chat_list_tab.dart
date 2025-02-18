import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/chat/controller/chat_controller.dart';
import 'package:app_law_order/src/pages/chat/view/components/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatListTab extends StatefulWidget {
  const ChatListTab({super.key});

  @override
  State<ChatListTab> createState() => _ChatListTab();
}

class _ChatListTab extends State<ChatListTab> {
  final chatController = Get.find<ChatController>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //print('didchange');
    // Aqui você pode executar o código que deseja quando a tela é chamada novamente
    chatController.didChangeScreen();
  }

  @override
  void dispose() {
    // Realize operações de limpeza ou libere recursos aqui

    super.dispose();
    chatController.disposeScreen();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisSize: MainAxisSize.max,

          children: [
            Text(
              'Conversas',
              style: TextStyle(
                fontSize: CustomFontSizes.fontSize18,
              ),
            ),
            const Divider(
              height: 20,
            ),
            GetBuilder<ChatController>(
              builder: (controller) {
                return controller.isLoading
                    ? Expanded(
                        child: Center(
                          child: Center(
                            child: //CircularProgressIndicator(),
                                LoadingAnimationWidget.discreteCircle(
                              color: CustomColors.blueDark2Color,
                              secondRingColor: CustomColors.blueDarkColor,
                              thirdRingColor: CustomColors.blueColor,
                              size: 50,
                            ),
                          ),
                        ),
                      )
                    : Visibility(
                        visible: controller.allChats.isNotEmpty,
                        replacement: Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  color: CustomColors.blueDarkColor,
                                ),
                                const Text('Não há itens para apresentar'),
                              ],
                            ),
                          ),
                        ),
                        child: Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) {
                              return ChatTile(
                                chat: controller.allChats[index],
                                logedUserId: controller.authController.user.id!,
                              );
                            },
                            itemCount: controller.allChats.length,
                            separatorBuilder: (BuildContext context, int index) => const Divider(
                              height: 0,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
