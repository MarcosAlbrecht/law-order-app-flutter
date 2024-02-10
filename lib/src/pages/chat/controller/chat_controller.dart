import 'package:app_law_order/src/models/chat_message_model.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/pages/base/controller/navigation_controller.dart';
import 'package:app_law_order/src/pages/chat/repository/chat_repository.dart';
import 'package:app_law_order/src/services/socket_io_manager.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  final chatRepository = ChatRepository();
  final utilServices = UtilServices();
  final navigationController = Get.find<NavigationController>();
  late RxInt _currentIndex;

  final url = 'https://sandbox.api.prestadio.com.br/chat';

  final hasUnreadMessages = false.obs;
  late String token;

  late IO.Socket socket;

  List<ChatModel> allChats = [];
  List<ChatMessageModel> allMessages = [];

  bool isLoading = false;
  bool isMessageLoading = false;
  bool isTabOpened = false;

  int get currentIndex => _currentIndex.value;

  @override
  Future<void> onInit() async {
    super.onInit();

    connect();
    loadChats();
  }

  void setTabOpened(bool value) {
    isTabOpened = value;
  }

  void setLoading(bool value) {
    isLoading = value;
  }

  void setMessageLoading(bool value) {
    isLoading = value;
  }

  Future<void> loadChats() async {
    final result = await chatRepository.getAllChats();
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
    socket.on('receive_message', (data) => handleNewMessage(data));
  }

  void handleNewMessage(dynamic data) {
    if (navigationController.currentIndex != 3) {}
  }

  void didChangeScreen() {
    setTabOpened(true);
    print('A tela ChatTab foi chamada novamente.');
  }

  void disposeScreen() {
    setTabOpened(false);
  }

  Future<void> loadMessages({required ChatModel chat}) async {
    setMessageLoading(true);
    final result = await chatRepository.getMessages(chat: chat);
    setMessageLoading(false);
    result.when(
        success: (data) {
          allMessages = data;
        },
        error: (message) {});
  }
}
