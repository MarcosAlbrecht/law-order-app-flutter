import 'dart:io';

import 'package:app_law_order/src/models/chat_message_model.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/chat/repository/chat_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  final chatRepository = ChatRepository();
  final utilServices = UtilServices();
  final authController = Get.find<AuthController>();

  late String userId;
  late RxInt _currentIndex;

  final url = 'https://sandbox.api.prestadio.com.br/chat';

  final hasUnreadMessages = false.obs;
  late String token;

  late IO.Socket socket;

  List<ChatModel> allChats = [];
  List<ChatMessageModel> allMessages = [];
  ChatModel? selectedChat = ChatModel();

  bool isLoading = false;
  bool isMessageLoading = true;
  bool isTabOpened = false;

  int get currentIndex => _currentIndex.value;

  @override
  Future<void> onInit() async {
    super.onInit();

    connect();
    loadChats();
    //userId = await utilServices.getToken()
  }

  void didChangeScreen() {
    setTabOpened(true);
    print('A tela ChatTab foi chamada novamente.');
  }

  void disposeScreen() {
    selectedChat = null;
    setTabOpened(false);
  }

  void setTabOpened(bool value) {
    isTabOpened = value;
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  void setMessagesLoading(bool value, {bool isUser = false}) {
    if (isUser) {
      isMessageLoading = value;
    }
    update();
  }

  Future<void> loadChats() async {
    setLoading(true);
    final result = await chatRepository.getAllChats();
    setLoading(false);
    result.when(success: (data) {
      allChats = data;
    }, error: (message) {
      if (message.isNotEmpty) {
        utilServices.showToast(message: message, isError: true);
      }
    });
  }

  void connect() async {
    token = await utilServices.getToken();

    socket = IO.io(
        url,
        IO.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            //.setExtraHeaders({'Authorization': token})
            .setQuery({'Authorization': token})
            // optional
            .build());

    _connectServer();
  }

  _connectServer() {
    socket.onConnect((data) => print('Connected on server'));
    socket.onConnectError((data) => print('Error on Connected server ' + data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('receive_message', (data) => handleReceiveNewMessage(data));
  }

  void handleReceiveNewMessage(dynamic data) {
    if (isTabOpened) {
      //adiciona a mensagem na lista e atualiza a tela
      //var userData = data as Map<String, dynamic>;
      ChatMessageModel message = ChatMessageModel.fromJson(data);
      message.createdAt = utilServices.getCurrentDateTimeInISO8601Format();
      allMessages.insert(0, message);
      update();
      // Agora você pode usar o objeto UserModel conforme necessário
      print('Nova mensagem de $message');
    } else {
      //envia showMessage
      utilServices.showToastNewChatMessage(message: 'Nova mensagem de chat recebida!');
    }
  }

  Future<void> handleSendMessage({required String message}) async {
    if (message.isEmpty) {}
  }

  Future<void> loadMessages({required ChatModel chat, bool canLoad = true}) async {
    if (canLoad) {
      setMessagesLoading(true);
    }

    final result = await chatRepository.getMessages(chat: chat);
    selectedChat = chat;

    setMessagesLoading(false, isUser: true);

    //setMessageLoading(false);
    result.when(
        success: (data) {
          allMessages.clear();
          allMessages.addAll(data);
        },
        error: (message) {});
  }

  Future<void> handleDownloadFile({required String url, required String fileName}) async {
    final Directory appDocumentsDir;
    if (Platform.isIOS) {
      appDocumentsDir = await getApplicationDocumentsDirectory();
    } else {
      appDocumentsDir = (await getDownloadsDirectory())!;
    }

    String documentDir = '${appDocumentsDir.path}/$fileName';
    final result = await chatRepository.downloadFile(url: url, savePath: documentDir);
    result.when(
        success: (data) {
          print('terminou o download');
        },
        error: (message) {});
  }
}
