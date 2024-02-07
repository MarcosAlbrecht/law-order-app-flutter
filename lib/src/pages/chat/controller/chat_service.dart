import 'package:app_law_order/src/services/socket_io_manager.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService extends GetxService {
  final url = 'https://sandbox.api.prestadio.com.br/chat';
  final utilServices = UtilServices();
  final hasUnreadMessages = false.obs;
  late String token;

  late IO.Socket socket;

  final receiveMessageCallbacks = <Function>[];

  @override
  Future<void> onInit() async {
    super.onInit();

    connect();
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
    socket.on('receive_message', (data) => print(data));
  }
}
