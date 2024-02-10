import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/chat/controller/chat_controller.dart';
import 'package:app_law_order/src/pages/chat/view/components/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    // Aqui você pode executar o código que deseja quando a tela é chamada novamente
    //chatController.didChangeScreen();
  }

  @override
  void dispose() {
    // Realize operações de limpeza ou libere recursos aqui
    //chatController.dispose(); // Por exemplo, se você tiver algum controlador, você pode chamar o método dispose() dele aqui

    super.dispose();
    //chatController.disposeScreen();
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
          mainAxisSize: MainAxisSize.max,
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
                return !controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Visibility(
                        visible: controller.allChats.isNotEmpty,
                        replacement: Center(
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
                        child: Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) {
                              return ChatTile(
                                chat: controller.allChats[index],
                              );
                            },
                            itemCount: controller.allChats.length,
                            separatorBuilder: (BuildContext context, int index) => const Divider(
                              height: 10,
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
