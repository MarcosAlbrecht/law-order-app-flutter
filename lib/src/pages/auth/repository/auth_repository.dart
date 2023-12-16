import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager httpManager = HttpManager();

  //Realiza o login com email e senha
  Future signIn({required String email, required String password}) async {
    final result = await httpManager.restRequest(
      method: HttpMethods.post,
      url: EndPoints.signin,
      body: {
        'email': email,
        'password': password,
      },
    );

    //return handleUserOrError(result);
  }
}
