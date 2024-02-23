import 'dart:developer';

import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/chat_message_model.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/pages/chat/result/chat_message_result.dart';
import 'package:app_law_order/src/pages/chat/result/chats_result.dart';
import 'package:app_law_order/src/pages/chat/result/download_file_result.dart';
import 'package:app_law_order/src/pages/chat/result/send_file_result.dart';
import 'package:app_law_order/src/services/http_manager.dart';

import 'package:dio/dio.dart';

class ChatRepository {
  final HttpManager httpManager = HttpManager();

  Future<ChatsResult<ChatModel>> getAllChats() async {
    try {
      final result = await httpManager.restRequest(
        url: EndPoints.getAllChats,
        method: HttpMethods.get,
      );

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

  Future<ChatsMessageResult<ChatMessageModel>> getMessages({required String userDestinationId}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.get,
        url: '${EndPoints.getChatMessage}$userDestinationId',
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
    } on Exception catch (e) {
      print(e);
      if (e == 404) {
        return ChatsMessageResult.error('Ainda não possui conversa iniciada');
      }
      return ChatsMessageResult.error('Não foi possível carregar as mensagens. Tente novamente mais tarde!');
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

  Future<SendFileResult> sendChatFile({required String file, required String userDestination}) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file, filename: file.split('/').last),
      // Adicione outros campos se necessário
    });

    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.post,
        url: '${EndPoints.sendFileMessage}$userDestination',
        body: formData,
      );

      if (result.isEmpty) {
        return SendFileResult.success('');
      } else {
        return SendFileResult.error('Não foi possivel enviar o arquivo.');
      }
    } catch (e) {
      log('Erro ao enviar arquivo', error: e);
      return SendFileResult.error('Tente novamente mais tarde.');
    }
  }
}
