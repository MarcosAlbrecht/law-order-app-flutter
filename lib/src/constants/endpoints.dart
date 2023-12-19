const String baseUrl = 'https://sandbox.api.prestadio.com.br';

abstract class EndPoints {
  static const signin = '$baseUrl/accounts/authentication/login';
  static const forgotPassword = '$baseUrl/accounts/users/recover-password';
}
