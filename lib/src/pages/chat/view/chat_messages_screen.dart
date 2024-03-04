// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/chat_message_model.dart';
import 'package:app_law_order/src/models/file_model.dart';
import 'package:app_law_order/src/pages/chat/controller/chat_controller.dart';
import 'package:app_law_order/src/pages/chat/view/components/custom_appbar.dart';
import 'package:app_law_order/src/pages/chat/view/components/picture_message_dialog.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class ChatMessageScreen extends StatefulWidget {
  ChatMessageScreen({super.key});

  final args = Get.arguments as Map<String, dynamic>;

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  final chatController = Get.find<ChatController>();
  final utilServices = UtilServices();
  late String userId;
  @override
  void dispose() {
    // Realize operações de limpeza ou libere recursos aqui
    chatController.disposeChatMessagesScreen();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    chatController.handleLoadingMessages(
        chat: widget.args['chat_model'], canLoad: true, userDestinationId: widget.args['userDestinationId'], isUser: false);
    print(widget.args);

    print('inicializou o chat message');
  }

  final messageEC = TextEditingController();

  void clearText() {
    messageEC.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: GetBuilder<ChatController>(
          builder: (controller) {
            if (controller.isMessageLoading) {
              return Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: CustomColors.blueDark2Color,
                  secondRingColor: CustomColors.blueDarkColor,
                  thirdRingColor: CustomColors.blueColor,
                  size: 50,
                ),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar(
                  user: controller.selectedChat != null
                      ? controller.authController.user.id! == controller.selectedChat?.destinationUserId!
                          ? controller.selectedChat!.user!
                          : controller.selectedChat!.destinationUser!
                      : null,
                  logedUserId: '',
                ),
                Expanded(
                  child: Visibility(
                    visible: controller.allMessages.isNotEmpty,
                    replacement: Container(),
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
                                    createdAt: message.createdAt!,
                                    message: message.message!,
                                    isMe: message.userId == controller.authController.user.id,
                                  )
                                : MessageFileBubble(
                                    fileName: message.fileName!,
                                    file: message.file!,
                                    isMe: message.userId == controller.authController.user.id,
                                    controller: controller,
                                    createdAt: message.createdAt!,
                                    onTap: (FileType fileType) async {
                                      // tratar a interação com o arquivo
                                      if (fileType == FileType.image) {
                                        await showDialog(
                                          context: context,
                                          builder: (_) {
                                            return PictureMessageDialog(
                                              imageUrl: message.file!.url!,
                                              onPressed: () async {
                                                await controller.handleDownloadFile(
                                                    url: message.file!.url!, fileName: message.fileName!);
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
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
                            suffixIconButtonAttach: () {
                              _handleAttachmentPressed(controller);
                            },
                            controller: messageEC,
                            label: 'Mensagem',
                            removeFloatingLabelBehavior: true,
                            onChanged: (value) {
                              messageEC.text = value!;
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
                                onPressed: () {
                                  _sendMessage(controller, null);
                                },
                                icon: const Icon(Icons.send),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleAttachmentPressed(ChatController controller) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              dense: true,
              leading: const Icon(Icons.photo),
              title: const Text('Foto'),
              onTap: () {
                Navigator.pop(context);
                _handleImageSelection(controller);
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Arquivo'),
              onTap: () {
                Navigator.pop(context);
                _handleFileSelection(controller);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancelar'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _handleFileSelection(ChatController controller) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null && result.files.single.path != null) {
      final fileModel = FileModel(
        createdAt: utilServices.getCurrentDateTimeInISO8601Format(),
        fileLocalPath: result.files.single.path,
      );
      final message = ChatMessageModel(
        fileName: result.files.single.name,
        file: fileModel,
      );

      _sendMessage(chatController, message);
    }
  }

  void _handleImageSelection(ChatController controller) async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      result.path;
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final fileModel = FileModel(
        createdAt: utilServices.getCurrentDateTimeInISO8601Format(),
        fileLocalPath: result.path,
      );
      final message = ChatMessageModel(
        fileName: result.name,
        file: fileModel,
      );

      _sendMessage(chatController, message);

      //_addMessage(message);
    }
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

  void _sendMessage(ChatController controller, ChatMessageModel? message) {
    final messageText = messageEC.text;
    if (messageText.isNotEmpty) {
      print('Mensagem enviada: $messageText');
      controller.handleSendNewSimpleMessage(message: messageText);
    } else if (message?.file?.fileLocalPath != null) {
      print('Mensagem com arquivo enviada: $message');
      controller.handleSendNewFileMessage(message: message!);
    }

    clearText();
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String createdAt;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.createdAt,
  }) : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isMe ? CustomColors.white : CustomColors.black,
                fontSize: CustomFontSizes.fontSize14,
              ),
            ),
            Text(
              utilServices.formatTime(createdAt),
              style: TextStyle(
                color: isMe ? CustomColors.white : CustomColors.black,
                fontSize: CustomFontSizes.fontSize12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageFileBubble extends StatelessWidget {
  final String fileName;
  final FileModel file;
  final bool isMe;
  final Function(FileType) onTap;
  final ChatController controller;
  final String createdAt;

  const MessageFileBubble({
    Key? key,
    required this.fileName,
    required this.file,
    required this.isMe,
    required this.onTap,
    required this.controller,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          FileType type = getFileType(fileName);
          onTap(type);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          //padding: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isMe ? CustomColors.blueDark2Color : CustomColors.backgroudCard,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
              bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
            ),
          ),
          child: getFileType(fileName) == FileType.image && file.url != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: size.height * .3, // Altura da imagem
                          width: size.width * .6, // Largura da imagem
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: file.url!,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  SquareProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              fit: BoxFit.cover,
                              height: 200,
                              width: 200,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0, // Alinha o widget na parte inferior
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 30, // Altura da sombra
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                              child: Text(
                                textAlign: TextAlign.right,
                                utilServices.formatTime(createdAt),
                                style: TextStyle(
                                  color: isMe ? CustomColors.white : CustomColors.black,
                                  fontSize: CustomFontSizes.fontSize12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () async {
                    await controller.handleDownloadFile(url: file.url!, fileName: fileName);
                  },
                  child: Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.insert_drive_file),
                            const SizedBox(width: 8),
                            Flexible(
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
                        Text(
                          utilServices.formatTime(createdAt),
                          style: TextStyle(
                            color: isMe ? CustomColors.white : CustomColors.black,
                            fontSize: CustomFontSizes.fontSize12,
                          ),
                        ),
                      ],
                    ),
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
        return FileType.any;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return FileType.image;
      case 'txt':
        return FileType.any;
      default:
        return FileType.any;
    }
  }
}
