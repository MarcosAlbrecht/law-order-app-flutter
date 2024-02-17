import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/chat_message_model.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/pages/chat/result/chat_message_result.dart';
import 'package:app_law_order/src/pages/chat/result/chats_result.dart';
import 'package:app_law_order/src/pages/chat/result/download_file_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';
import 'package:get/get.dart';

class ChatRepository {
  final HttpManager httpManager = HttpManager();

  Future<ChatsResult<ChatModel>> getAllChats() async {
    final result = await httpManager.restRequest(
      url: EndPoints.getAllChats,
      method: HttpMethods.get,
    );
    try {
      if (result != null && result[0]['statusCode'] == null) {
        List<ChatModel> data = (List<Map<String, dynamic>>.from(result)).map(ChatModel.fromJson).toList();
        return ChatsResult.success(data);
      } else if (result.isEmpty) {
        List<ChatModel> data = [];
        return ChatsResult.success(data);
      } else if (result['statusCode'] != null && int.tryParse(result['statusCode']) == 404) {
        return ChatsResult.error('Erro ao carregar a lista de chats!');
      } else {
        return ChatsResult.error('');
      }
    } catch (e) {
      print(e);
      List<ChatModel> data = [];
      return ChatsResult.success(data);
    }
  }

  Future<ChatsMessageResult<ChatMessageModel>> getMessages({required ChatModel chat}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.get,
      url: '${EndPoints.getChatMessage}${chat.chatId}',
    );

    if (result.isNotEmpty) {
      List<ChatMessageModel> data = (List<Map<String, dynamic>>.from(result)).map(ChatMessageModel.fromJson).toList();
      return ChatsMessageResult.success(data);
    } else if (result.isEmpty) {
      List<ChatMessageModel> data = [];
      return ChatsMessageResult.success(data);
    } else {
      return ChatsMessageResult.error('Erro ao carregar as mensagens!');
    }
  }

  Future<DownloadFileResult> downloadFile({
    required String url,
    required String savePath,
  }) async {
    // Obtém o diretório de armazenamento externo do dispositivo

    final result = await httpManager.downloadFile(url: url, savePath: savePath);

    if (result.statusCode == 200) {
      String data = 'Download finalizado!';
      return DownloadFileResult.success(data);
    }
    String data = 'Erro ao realizar download!';
    return DownloadFileResult.success(data);
  }
}
