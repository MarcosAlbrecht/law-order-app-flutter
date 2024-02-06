import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  late IO.Socket? _socket;
  final Map<String, Function> eventCallbacks = {};

  SocketManager(String baseURL, String accessToken) {
    final url = '$baseURL/chat?Authorization=$accessToken';

    _socket = IO.io(
      url,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    /// Adicione o ouvinte de evento 'receive_message'
    socket.on('receive_message', (data) {
      // Chame a função registrada para este evento
      print(data);
      if (eventCallbacks.containsKey('receive_message')) {
        eventCallbacks['receive_message']!(data);
      }
    });

    // Configure os ouvintes de eventos
    socket.onConnect((data) => onConnect());
    socket.onConnectError((data) => onConnectError(data));
    socket.onDisconnect((data) => onDisconnect());
  }
  void registrarCallback(String evento, Function callback) {
    eventCallbacks[evento] = callback;
  }

  IO.Socket get socket {
    if (_socket == null) {
      throw Exception('Chame o construtor antes de acessar o socket.');
    }
    return _socket!;
  }

  void closeSocket() {
    if (_socket != null) {
      _socket!.disconnect();
    }
  }

  // Método chamado quando a conexão é estabelecida
  void onConnect() {
    print('Connection estabilished');
  }

  // Método chamado em caso de erro de conexão
  void onConnectError(dynamic data) {
    print('Connect error: $data');
  }

  // Método chamado quando a conexão é encerrada
  void onDisconnect() {
    print('Disconnect from server socket.io');
  }

  // Método para enviar uma mensagem
  void sendMessage(String message) {
    // Substitua 'send_message' pelo evento apropriado no seu servidor
    socket.emit('send_message', message);
  }
}
