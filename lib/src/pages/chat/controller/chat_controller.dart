import 'dart:io';

import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/chat_message_model.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/chat/repository/chat_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  final chatRepository = ChatRepository();
  final utilServices = UtilServices();
  final authController = Get.find<AuthController>();

  late String userId;
  late String destinationUser;
  late RxInt _currentIndex;

  final url = EndPoints.baseUrlChat;

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
    loadChats();
    print('A tela ChatTab foi chamada novamente.');
  }

  void disposeScreen() {
    selectedChat = null;
    setTabOpened(false);
  }

  void disposeChatMessagesScreen() async {
    //allMessages.clear();
    await loadChats(canload: false);
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

  Future<void> loadChats({bool canload = true}) async {
    if (canload) {
      setLoading(true);
    }

    final result = await chatRepository.getAllChats();
    if (canload) {
      setLoading(false);
    }
    result.when(success: (data) {
      allChats.clear();
      allChats.addAll(data);
      //allChats.sort((a, b) => (a.createdAt ?? '').compareTo(b.createdAt ?? ''));
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
      message.userId = data['author']['_id'];
      allMessages.insert(0, message);
      update();
      // Agora você pode usar o objeto UserModel conforme necessário
      print('Nova mensagem de $message');
    } else {
      //envia showMessage
      utilServices.showToastNewChatMessage(message: 'Nova mensagem de chat recebida!');
    }
  }

  void handleLoadingMessages({
    ChatModel? chat,
    String? userDestinationId,
    bool canLoad = true,
  }) {
    destinationUser = '';
    //allChats = [];

    if (chat != null) {
      if (authController.user.id == chat.destinationUserId) {
        destinationUser = chat.userId!;
      } else {
        destinationUser = chat.destinationUserId!;
      }
    } else {
      destinationUser = userDestinationId!;
    }

    loadMessages(userDestinationId: destinationUser, canLoad: canLoad);
  }

  Future<void> loadMessages({required String userDestinationId, bool canLoad = true}) async {
    if (canLoad) {
      setMessagesLoading(true, isUser: true);
    }

    final result = await chatRepository.getMessages(userDestinationId: userDestinationId);
    destinationUser = userDestinationId;
    //selectedChat = chat;

    setMessagesLoading(false, isUser: true);

    //setMessageLoading(false);
    result.when(success: (data) {
      allMessages.clear();
      allMessages.addAll(data);
    }, error: (message) {
      allMessages = [];
    });
  }

  Future<void> handleDownloadFile({required String url, required String fileName}) async {
    final Directory appDocumentsDir;
    if (Platform.isIOS) {
      appDocumentsDir = (await getExternalStorageDirectory())!;
    } else {
      appDocumentsDir = (await getDownloadsDirectory())!;
    }

    if ((File('${appDocumentsDir.path}/$fileName').existsSync())) {
      print('arquivo ja foi baixado');
      //abrir arquivo baixado
    } else {
      String documentDir = '${appDocumentsDir.path}/$fileName';
      final result = await chatRepository.downloadFile(url: url, savePath: documentDir);
      result.when(
          success: (data) {
            print('terminou o download');
          },
          error: (message) {});
    }

    await OpenFilex.open('${appDocumentsDir.path}/$fileName');
  }

  Future<void> handleSendNewSimpleMessage({
    required String message,
  }) async {
    // final String? destinationUserId;
    // if (authController.user.id == userDestinationId) {
    //   destinationUserId = selectedChat?.userId;
    // } else {
    //   destinationUserId = selectedChat?.destinationUserId;
    // }

    try {
      socket.emit(
        'message',
        {
          'message': message,
          'destinationUserId': destinationUser,
        },
      );
    } on Exception catch (e) {
      utilServices.showToast(message: 'Não foi possivel enviar a mensagem, Tente novamente mais tarde!');
    }
  }

  Future<void> handleSendNewFileMessage({required ChatMessageModel message}) async {
    //final String? destinationUserId;
    message.userId = authController.user.id;
    message.createdAt = utilServices.getCurrentDateTimeInISO8601Format();
    message.authorFirstName = authController.user.firstName;
    message.authorLastName = authController.user.lastName;
    //setLoading(true);
    final result = await chatRepository.sendChatFile(
      file: message.file!.fileLocalPath!,
      userDestination: destinationUser,
    );
    result.when(
      success: (data) {
        //allMessages.insert(0, message);
      },
      error: (message) {
        utilServices.showToast(message: 'Ocorreu um erro ao enviar o arquivo, tente novamente mais tarde');
      },
    );

    //setLoading(true);
  }
}
