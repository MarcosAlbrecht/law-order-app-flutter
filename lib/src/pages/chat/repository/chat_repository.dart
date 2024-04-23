import 'dart:developer';

import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/chat_message_model.dart';
import 'package:app_law_order/src/models/chat_model.dart';
import 'package:app_law_order/src/models/fast_payment_model.dart';
import 'package:app_law_order/src/models/payment_model.dart';
import 'package:app_law_order/src/pages/chat/result/chat_message_result.dart';
import 'package:app_law_order/src/pages/chat/result/chats_result.dart';
import 'package:app_law_order/src/pages/chat/result/download_file_result.dart';
import 'package:app_law_order/src/pages/chat/result/payment_result.dart';
import 'package:app_law_order/src/pages/chat/result/payments_wallet_result.dart';
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

      if (result is List<Map<String, dynamic>>) {
        // Se result for uma lista de mapas, trata como mensagens válidas
        List<ChatMessageModel> data = result.map((message) => ChatMessageModel.fromJson(message)).toList();
        return ChatsMessageResult.success(data);
      } else if (result is List && result.isNotEmpty && result[0] is Map<String, dynamic>) {
        // Se result for uma lista com pelo menos um mapa e o primeiro mapa tiver uma chave 'statusCode'
        if (result[0]['statusCode'] == 404) {
          // Se o status code for 404, retorna uma lista vazia indicando que o chat não foi encontrado
          return ChatsMessageResult.error('Erro ao carregar as mensagens!');
        } else {
          List<ChatMessageModel> data = (List<Map<String, dynamic>>.from(result)).map(ChatMessageModel.fromJson).toList();
          return ChatsMessageResult.success(data);
        }
      } else {
        // Se não for possível determinar o formato dos dados, retorna um erro genérico
        return ChatsMessageResult.error('Erro ao carregar as mensagens!');
      }
    } on Exception {
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

  Future<PaymentResult> generatePayment({required String userDestination, required num value}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.post,
        url: EndPoints.generatePaymentLinkChat,
        body: {
          "value": value,
          "destinationUserId": userDestination,
        },
      );

      if (result.isNotEmpty) {
        var userData = result as Map<String, dynamic>;
        PaymentModel data = PaymentModel.fromJson(userData);
        return PaymentResult.success(data);
      } else {
        return PaymentResult.error('Não foi possivel gerar o pagamento.');
      }
    } catch (e) {
      log('Erro ao gerar link de pagamento', error: e);
      return PaymentResult.error('Tente novamente mais tarde.');
    }
  }

  Future<PaymentsWalletResult<FastPaymentModel>> getPaymentsWallet({required String userDestinationId}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.get,
        url: '${EndPoints.getPaymentsWallet}$userDestinationId',
      );

      if (result.isNotEmpty && result is List) {
        List<FastPaymentModel> data = result.map((message) => FastPaymentModel.fromJson(message)).toList();
        return PaymentsWalletResult.success(data);
      } else if (result.isEmpty) {
        List<FastPaymentModel> data = [];
        return PaymentsWalletResult.success(data);
      } else {
        return PaymentsWalletResult.error('Não foi possivel gerar o pagamento.');
      }
    } catch (e) {
      log('Erro ao gerar link de pagamento', error: e);
      return PaymentsWalletResult.error('Tente novamente mais tarde.');
    }
  }

  Future<PaymentsWalletResult<FastPaymentModel>> sendPayment({required String paymentId}) async {
    try {
      final result = await httpManager.restRequest(
        method: HttpMethods.patch,
        url: '${EndPoints.sendPayment}$paymentId',
      );

      if (result.isNotEmpty && result['message'] != null) {
        List<FastPaymentModel> data = [];
        return PaymentsWalletResult.success(data);
      } else {
        return PaymentsWalletResult.error('Não foi possivel gerar o pagamento.');
      }
    } catch (e) {
      log('Erro ao gerar link de pagamento', error: e);
      return PaymentsWalletResult.error('Tente novamente mais tarde.');
    }
  }
}
