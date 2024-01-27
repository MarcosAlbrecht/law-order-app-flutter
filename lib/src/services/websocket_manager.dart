import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager {
  late WebSocketChannel _channel;

  // Construtor que recebe o URL, um mapa de queryParams e um token
  WebSocketManager(
      String url, Map<String, dynamic>? queryParams, String? token) {
    connect(url, queryParams, token);
  }

  // Método para conectar ao WebSocket
  void connect(String url, Map<String, dynamic>? queryParams, String? token) {
    // Adiciona parâmetros à URL se fornecidos
    if (queryParams != null && queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map((entry) => '${entry.key}=${entry.value}')
          .join('&');
      url += (url.contains('?') ? '&' : '?') + queryString;
    }

    // Headers da requisição
    final defaultHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    // Adiciona o token aos headers, se fornecido
    if (token != null) {
      defaultHeaders['Authorization'] = 'Bearer $token';
    }

    _channel = IOWebSocketChannel.connect(url, headers: defaultHeaders);
  }

  // Método para enviar uma mensagem para o WebSocket
  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  // Método para receber mensagens do WebSocket
  Stream<dynamic> get onMessage => _channel.stream;

  // Método para fechar a conexão WebSocket
  void close() {
    _channel.sink.close();
  }
}
