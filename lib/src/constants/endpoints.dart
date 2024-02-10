const String baseUrl = 'https://sandbox.api.prestadio.com.br';

const String baseUrlViaCep = 'https://viacep.com.br/';

abstract class EndPoints {
  static const signin = '$baseUrl/accounts/authentication/login';
  static const forgotPassword = '$baseUrl/accounts/users/recover-password';
  static const createUser = '$baseUrl/accounts/users';
  static const updateUser = '$baseUrl/accounts/users';
  static const getUserById = '$baseUrl/accounts/users/';
  static const getAllUsersPaginated = '$baseUrl/accounts/users';
  static const updateProfilePicture = '$baseUrl/accounts/users/update-profile-picture';

  static const getStates = '$baseUrl/accounts/users/find-states';
  static const getCities = '$baseUrl/accounts/users/find-cities';

  static const getFollows = '$baseUrl/accounts/follows/follows';
  static const getFollowers = '$baseUrl/accounts/follows/followers';
  static const setFollow = '$baseUrl/accounts/follows/follow/';
  static const setUnFollow = '$baseUrl/accounts/follows/unfollow/';
  static const insertPortfolioPicture = '$baseUrl/accounts/users/add-portfolio-pictures';
  static const deletePortfolioPicture = '$baseUrl/accounts/users/remove-portfolio-picture/';
  static const getNotifications = '$baseUrl/notifications';
  static const updateNotification = '$baseUrl/notifications/read/';

  static const setUserService = '$baseUrl/accounts/users/add-services';
  static const deleteUserService = '$baseUrl/accounts/users/remove-service/';
  static const updateUserService = '$baseUrl/accounts/users/update-service/';

  static const setServiceRequest = '$baseUrl/accounts/service-requests/request/';

  static const getRequestsReceived = '$baseUrl/accounts/service-requests';
  static const getRequestsReceivedById = '$baseUrl/accounts/service-requests/';
  static const getMyRequest = '$baseUrl/accounts/service-requests/my';

  static const acceptBudget = '$baseUrl/accounts/service-requests/set-provider-acceptance/';

  static const declineBudget = '$baseUrl/accounts/service-requests/decline-budget/';

  static const openContest = '$baseUrl/accounts/service-requests/open-contest/';

  static const completeService = '$baseUrl/accounts/service-requests/complete-service-as-a-provider/';
  static const completeServiceUser = '$baseUrl/accounts/service-requests/complete-service/';
  static const sendAvaliation = '$baseUrl/accounts/recommendations/recommend/';

  static const cancelRequest = '$baseUrl/accounts/service-requests/cancel-request/';
  //mercado pago -->
  static const generatePaymentLink = '$baseUrl/mercadopago/generate-payment-link';
  //<--

  //endpois chat
  static const getAllChats = '$baseUrl/messages/list-all-chats';
  static const getChatMessage = '$baseUrl/messages/';
  //
}

abstract class EndPointsViaCep {
  static const cep = '$baseUrlViaCep/ws/';
}
