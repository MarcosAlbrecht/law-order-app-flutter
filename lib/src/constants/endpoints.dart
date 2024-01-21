const String baseUrl = 'https://sandbox.api.prestadio.com.br';

const String baseUrlViaCep = 'https://viacep.com.br/';

abstract class EndPoints {
  static const signin = '$baseUrl/accounts/authentication/login';
  static const forgotPassword = '$baseUrl/accounts/users/recover-password';
  static const createUser = '$baseUrl/accounts/users';
  static const updateUser = '$baseUrl/accounts/users';
  static const getUserById = '$baseUrl/accounts/users/';
  static const getAllUsersPaginated = '$baseUrl/accounts/users';
  static const updateProfilePicture =
      '$baseUrl/accounts/users/update-profile-picture';

  static const getFollows = '$baseUrl/accounts/follows/follows';
  static const getFollowers = '$baseUrl/accounts/follows/followers';
  static const setFollow = '$baseUrl/accounts/follows/follow/';
  static const setUnFollow = '$baseUrl/accounts/follows/unfollow/';
  static const insertPortfolioPicture =
      '$baseUrl/accounts/users/add-portfolio-pictures';
  static const deletePortfolioPicture =
      '$baseUrl/accounts/users/remove-portfolio-picture/';

  static const setUserService = '$baseUrl/accounts/users/add-services';
  static const deleteUserService = '$baseUrl/accounts/users/remove-service/';
  static const updateUserService = '$baseUrl/accounts/users/update-service/';

  static const setServiceRequest =
      '$baseUrl/accounts/service-requests/request/';

  static const getRequestsReceived = '$baseUrl/accounts/service-requests';
  static const getMyRequest = '$baseUrl/accounts/service-requests/my';

  static const acceptBudget =
      '$baseUrl/accounts/service-requests/accept-budget/';

  static const declineBudget =
      '$baseUrl/accounts/service-requests/decline-budget/';
}

abstract class EndPointsViaCep {
  static const cep = '$baseUrlViaCep/ws/';
}
