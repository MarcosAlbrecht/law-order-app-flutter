import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/chat_message_model.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/pages/chat/result/chat_message_result.dart';
import 'package:app_law_order/src/pages/chat/result/chats_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';

class ChatRepository {
  final HttpManager httpManager = HttpManager();

  Future<ChatsResult<ChatModel>> getAllChats() async {
    final result = await httpManager.restRequest(
      url: EndPoints.getAllChats,
      method: HttpMethods.get,
    );

    if (result.isNotEmpty && result['statusCode'] == null) {
      List<ChatModel> data = (List<Map<String, dynamic>>.from(result)).map(ChatModel.fromJson).toList();
      return ChatsResult.success(data);
    } else if (result.isEmpty) {
      List<ChatModel> data = [];
      return ChatsResult.success(data);
    } else if (result['statusCode'] != null && result['statusCode'] == 404) {
      return ChatsResult.error('Erro ao carregar a lista de chats!');
    } else {
      return ChatsResult.error('');
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
}
