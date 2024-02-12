import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/models/message_file_model.dart';
import 'package:app_law_order/src/pages/chat/controller/chat_controller.dart';
import 'package:app_law_order/src/pages/chat/view/components/picture_message_dialog.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

enum FileType {
  PDF,
  Image,
  Text,
  Other,
}

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            controller.allMessages[index].file == null
                                ? MessageBubble(
                                    message: message.message!,
                                    isMe: message.userId == controller.authController.user.id,
                                  )
                                : MessageFileBubble(
                                    fileName: message.fileName!,
                                    file: message.file!,
                                    isMe: message.userId == controller.authController.user.id,
                                    onTap: (FileType fileType) async {
                                      // Aqui você pode implementar a lógica para tratar a interação com o arquivo
                                      if (fileType == FileType.Image) {
                                        await showDialog(
                                          context: context,
                                          builder: (_) {
                                            return PictureMessageDialog(imageUrl: message.file!.url!);
                                          },
                                        );
                                        //showImageFullScreen(message.file.url);
                                      } else {
                                        // Fazer o download do arquivo
                                        //downloadFile(message.file?.url, message.fileName!);
                                      }
                                    },
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    //color: CustomColors.blueDark2Color,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            //icon: Icons.search,
                            suffixIconButtonAttach: () {},
                            label: 'Mensage',
                            removeFloatingLabelBehavior: true,
                            onChanged: (value) {
                              //controller.searchRequest.value = value!.toLowerCase();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 5),
                          child: SizedBox(
                            width: 60,
                            height: double.infinity,
                            child: Material(
                              color: CustomColors.blueDark2Color,
                              //elevation: 3,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: IconButton(
                                color: CustomColors.white,
                                onPressed: () {},
                                icon: const Icon(Icons.send),
                              ),
                            ),
                          ),
                        ),
                      ],
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
      return utilServices.formatDate(dateString);
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
          color: isMe ? CustomColors.blueDark2Color : CustomColors.backgroudCard,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? CustomColors.white : CustomColors.black,
            fontSize: CustomFontSizes.fontSize14,
          ),
        ),
      ),
    );
  }
}

class MessageFileBubble extends StatelessWidget {
  final String fileName;
  final MessageFileModel file;
  final bool isMe;
  final Function(FileType) onTap;

  const MessageFileBubble({super.key, required this.fileName, required this.file, required this.isMe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          FileType type = getFileType(fileName);
          onTap(type);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(12),
          child: getFileType(fileName) == FileType.Image && file.url != null
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isMe ? CustomColors.blueColor : CustomColors.backgroudCard,
                      width: 2,
                    ), // Definindo a borda
                    borderRadius: BorderRadius.circular(8), // Arredondando as bordas
                  ),
                  child: CachedNetworkImage(
                    imageUrl: file.url!,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 200,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                )
              : DecoratedBox(
                  decoration: BoxDecoration(
                    color: isMe ? CustomColors.blueDark2Color : CustomColors.backgroudCard,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
                      bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.insert_drive_file),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          fileName,
                          style: TextStyle(
                            color: isMe ? CustomColors.white : CustomColors.black,
                            fontSize: CustomFontSizes.fontSize14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  FileType getFileType(String fileName) {
    String extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return FileType.PDF;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return FileType.Image;
      case 'txt':
        return FileType.Text;
      default:
        return FileType.Other;
    }
  }
}
