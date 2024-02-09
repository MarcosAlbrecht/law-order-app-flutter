import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/pages/chat/result/chats_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';

class ChatRepository {
  final HttpManager httpManager = HttpManager();

  Future<ChatsResult<ChatModel>> getAllChats() async {
    final result = await httpManager.restRequest(
      url: EndPoints.getAllChats,
      method: HttpMethods.get,
    );

    if (result.isNotEmpty) {
      List<ChatModel> data = (List<Map<String, dynamic>>.from(result)).map(ChatModel.fromJson).toList();
      return ChatsResult.success(data);
    } else if (result.isEmpty) {
      List<ChatModel> data = [];
      return ChatsResult.success(data);
    } else {
      return ChatsResult.error('Erro ao carregar os chats!');
    }
  }
}
