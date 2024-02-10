import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/pages/chat/controller/chat_controller.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ChatMessageScreen extends StatefulWidget {
  const ChatMessageScreen({super.key});

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  final chatController = Get.find<ChatController>();
  final utilServices = UtilServices();
  late String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('inicializou o chat message');
  }

  // final List<Map<String, dynamic>> _messages = [
  //   {
  //     "_id": "65c58f8773946074f448de58",
  //     "message": "ola",
  //     "destinationUserId": "658ba421312b6cda7c48s1",
  //     "seen": false,
  //     "authorFirstName": "Marcos",
  //     "file": null,
  //     "authorLastName": "Roberto",
  //     "authorProfilePictureUrl": null,
  //     "chatId": "65c18b4273946074f448da33",
  //     "userId": "658b90d4312b6cda7c4810a9",
  //     "createdAt": "2024-02-09T02:35:51.306Z"
  //   },
  //   {
  //     "_id": "65c1a71c73946074f448da46",
  //     "message": "teste 2",
  //     "destinationUserId": "658b90d4312b6cda7c4810a9",
  //     "seen": false,
  //     "authorFirstName": "Marcos Roberto",
  //     "file": null,
  //     "authorLastName": "Albrecht",
  //     "authorProfilePictureUrl":
  //         "https://law-order-files.s3.sa-east-1.amazonaws.com/bc3b01d6-b6ca-4537-9feb-26604a52e470-compressed_7344b77a-acf6-4667-844f-d1f864825bf11119758446961173729.jpg",
  //     "chatId": "65c18b4273946074f448da33",
  //     "userId": "658ba421312b6cda7c4810b1",
  //     "createdAt": "2024-02-06T03:27:24.011Z"
  //   },
  // Adicione mais mensagens conforme necessário
  //];
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    chatController.loadMessages(chat: args['chat_model'], canLoad: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Chat App'),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: GetBuilder<ChatController>(
          builder: (controller) {
            if (controller.isMessageLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Visibility(
              visible: controller.allMessages.isNotEmpty,
              replacement: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      color: CustomColors.blueDarkColor,
                    ),
                    const Text('Não há mensagens para apresentar'),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.allMessages.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        final message = controller.allMessages[index];
                        final previousMessage =
                            index < controller.allMessages.length - 1 ? controller.allMessages[index + 1] : null;
                        final isDifferentDay =
                            previousMessage != null && !isSameDay(message.createdAt!, previousMessage.createdAt!);

                        return Column(
                          children: [
                            if (isDifferentDay)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  getMessageDay(message.createdAt!),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            MessageBubble(
                              message: message.message!,
                              isMe: message.userId == controller.authController.user.id,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Digite sua mensagem...',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            _sendMessage();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool isSameDay(String dateString1, String dateString2) {
    final DateTime date1 = DateTime.parse(dateString1);
    final DateTime date2 = DateTime.parse(dateString2);
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  String getMessageDay(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    final now = DateTime.now();
    if (isSameDay(dateString, now.subtract(const Duration(days: 1)).toIso8601String())) {
      return 'Ontem';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _sendMessage() {
    final messageText = _messageController.text;
    if (messageText.isNotEmpty) {
      print('Mensagem enviada: $messageText');
      _messageController.clear();
    }
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const MessageBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
