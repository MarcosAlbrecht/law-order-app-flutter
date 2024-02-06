import 'package:app_law_order/src/services/socket_io_manager.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService extends GetxService {
  final utilServices = UtilServices();
  final hasUnreadMessages = false.obs;

  late IO.Socket _socket;

  final receiveMessageCallbacks = <Function>[];

  @override
  void onInit() {
    super.onInit();
    initSocket();
  }

  void initSocket() async {
    IO.Socket socket = IO.io('http://localhost:3000');
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  // Método chamado ao receber uma nova mensagem
  void onReceiveMessage(dynamic data) {
    // Notifique todos os callbacks registrados
    for (var callback in receiveMessageCallbacks) {
      callback(data);
    }
  }

  // Método para registrar um callback para receber mensagens
  void registrarCallbackReceberMensagem(Function callback) {
    receiveMessageCallbacks.add(callback);
  }
}
