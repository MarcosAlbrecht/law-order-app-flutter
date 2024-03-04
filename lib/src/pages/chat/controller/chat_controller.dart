import 'dart:io';

import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/chat_message_model.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/base/controller/navigation_controller.dart';
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
  final navigationController = Get.find<NavigationController>();

  late String userId;
  late String destinationUser;
  bool firstMessage = false;
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
  bool isMessageScreenOpened = false;

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

  void didChangeMessageScreen() {
    setMessageScreenOpened(true);
    loadChats();
    print('A tela ChatTab foi chamada novamente.');
  }

  void disposeScreen() {
    selectedChat = ChatModel();
    setTabOpened(false);
  }

  void disposeChatMessagesScreen() async {
    //allMessages.clear();
    firstMessage = false;
    setMessageScreenOpened(false);
    await loadChats(canload: false);
    isMessageLoading = true;
  }

  void setTabOpened(bool value) {
    isTabOpened = value;
  }

  void setMessageScreenOpened(bool value) {
    isMessageScreenOpened = value;
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  void setMessagesLoading(bool value, {bool isUser = true}) {
    if (isUser) {
      isMessageLoading = value;
    }
    if (isUser) {
      update();
    }
  }

  static int compareCreatedAt(ChatModel a, ChatModel b) {
    DateTime dateTimeA = DateTime.parse(a.createdAt!);
    DateTime dateTimeB = DateTime.parse(b.createdAt!);
    return dateTimeB.compareTo(dateTimeA);
  }

  Future<void> loadChats({bool canload = true}) async {
    if (canload) {
      setLoading(true);
    }

    final result = await chatRepository.getAllChats();

    result.when(success: (data) async {
      allChats.clear();
      allChats.addAll(data);
      allChats.sort(compareCreatedAt);
    }, error: (message) {
      if (message.isNotEmpty) {
        utilServices.showToast(message: message, isError: true);
      }
    });

    setLoading(false);
  }

  void connect() async {
    token = await utilServices.getToken();

    socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            //.setExtraHeaders({'Authorization': token})
            .setQuery({'Authorization': token})
            .enableAutoConnect()
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
    if (isTabOpened || isMessageScreenOpened) {
      ChatMessageModel message = ChatMessageModel.fromJson(data);
      message.createdAt = utilServices.getCurrentDateTimeInISO8601Format();
      message.userId = data['author']['_id'];
      allMessages.insert(0, message);
      if (!isMessageScreenOpened) {
        loadChats(canload: false);
      }
      update();

      print('Nova mensagem de $message');
    } else {
      utilServices.showToastNewChatMessage(message: 'Nova mensagem de chat recebida!');
    }
  }

  void handleLoadingMessages({
    ChatModel? chat,
    String? userDestinationId,
    bool canLoad = true,
    bool isUser = true,
  }) {
    setMessageScreenOpened(true);
    destinationUser = '';
    allMessages = [];

    if (chat != null) {
      if (authController.user.id == chat.destinationUserId) {
        destinationUser = chat.userId!;
      } else {
        destinationUser = chat.destinationUserId!;
      }
      selectedChat = chat;
    } else {
      destinationUser = userDestinationId!;
    }
    selectedChat = allChats.firstWhereOrNull((c) => c.userId == destinationUser || c.destinationUserId == destinationUser);

    if (selectedChat == null) {
      firstMessage = true;
    }
    loadMessages(userDestinationId: destinationUser, canLoad: canLoad, isUser: isUser);
  }

  Future<void> loadMessages({required String userDestinationId, bool canLoad = true, bool isUser = true}) async {
    if (canLoad) {
      setMessagesLoading(true, isUser: isUser);
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
    try {
      if (Platform.isIOS) {
        appDocumentsDir = (await getDownloadsDirectory())!;
      } else {
        appDocumentsDir = (await getDownloadsDirectory())!;
      }
    } on Exception catch (e) {
      utilServices.showToast(message: 'Não foi possivel baixar o arquivo. Tente novamente mais tarde!');
      return;
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
    try {
      socket.emit(
        'message',
        {
          'message': message,
          'destinationUserId': destinationUser,
        },
      );
    } on Exception {
      utilServices.showToast(message: 'Não foi possivel enviar a mensagem, Tente novamente mais tarde!');
    }

    if (firstMessage) {
      firstMessage = false;
      loadChats(canload: false);
      loadMessages(userDestinationId: destinationUser, canLoad: false);
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
