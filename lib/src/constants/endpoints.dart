const String baseUrl = 'https://sandbox.api.prestadio.com.br';

const String baseUrlViaCep = 'https://viacep.com.br/';

abstract class EndPoints {
  static const signin = '$baseUrl/accounts/authentication/login';
  static const forgotPassword = '$baseUrl/accounts/users/recover-password';
  static const createUser = '$baseUrl/accounts/users';
  static const updateUser = '$baseUrl/accounts/users';
  static const getAllUsersPaginated = '$baseUrl/accounts/users';
  static const updateProfilePicture =
      '$baseUrl/accounts/users/update-profile-picture';

  static const getFollows = '$baseUrl/accounts/follows/follows';
}

abstract class EndPointsViaCep {
  static const cep = '$baseUrlViaCep/ws/';
}
