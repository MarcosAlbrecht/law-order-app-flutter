import 'package:app_law_order/src/services/util_services.dart';
import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class HttpManager {
  Future restRequest({
    required String url,
    required String method,
    Map? headers,
    dynamic body,
    Map<String, dynamic>? queryParams,
  }) async {
    // Headers da requisição
    final utilServices = UtilServices();
    final token = await utilServices.getToken();

    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
      });

    //enviar o token do user poi é obrigatorio para fazer as chamadas da API
    if (token != null && defaultHeaders['Authorization'] == null) {
      defaultHeaders['Authorization'] = 'Bearer $token';
    }

    Dio dio = Dio();

    try {
      Response response = await dio.request(
        url,
        queryParameters: queryParams,
        options: Options(
          method: method,
          headers: defaultHeaders,
        ),
        data: body,
      );
      //retorno do resutlado do server back
      return response.data;
      // ignore: deprecated_member_use
    } on DioError catch (error) {
      //erro do dio

      return error.response?.data ?? {};
    } catch (error) {
      return {};
    }
  }

  Future downloadFile({
    required String url,
    required String savePath,
  }) async {
    Dio dio = Dio();

    try {
      // Realiza a requisição GET para o URL do arquivo
      Response response = await dio.download(
        url,
        savePath,
        options: Options(responseType: ResponseType.bytes),
      );

      // Verifica se o download foi bem-sucedido
      if (response.statusCode == 200) {
        print('Download concluído: $savePath');
        return response.data;
      } else {
        print('Falha ao baixar o arquivo: ${response.statusCode}');
        return response.data;
      }
    } catch (e) {
      // Em caso de erro, informa o usuário
      print('Erro ao baixar o arquivo: $e');
    }
  }
}
