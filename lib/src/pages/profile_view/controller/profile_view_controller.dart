import 'package:app_law_order/src/models/follows_model.dart';
import 'package:app_law_order/src/models/metadata_recommendations_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/home/controller/home_controller.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:app_law_order/src/pages/profile_view/repository/profile_view_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';

int itemsPerPage = 10;

class ProfileViewController extends GetxController {
  final profileViewRepository = ProfileViewRepository();
  final homeController = Get.find<HomeController>();

  final utilService = UtilServices();
  FollowsModel? followed = FollowsModel();
  MetadataRecommendationsModel recommendations = MetadataRecommendationsModel();
  late MetadataRecommendationsModel currentRecommendations;

  UserModel user = UserModel();
  late String userID;

  bool isLoading = true;
  int pagination = 0;

  bool get isLastPage {
    if (currentRecommendations.recommendations!.length < itemsPerPage) return true;

    return pagination + itemsPerPage > recommendations.recommendations!.length;
  }

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>;
    final String idUser = arguments['idUser'];
    userID = idUser;
    loadData();
  }

  Future<void> loadData() async {
    setLoading(value: true);
    List<Future<void>> operations = [
      loadRecommendations(),
      loadUser(),
    ];

    await Future.wait(operations);
    setLoading(value: false);
  }

  Future<void> loadRecommendations({bool canLoad = true}) async {
    final result = await profileViewRepository.getRecommendations(skip: pagination, limit: itemsPerPage, userID: userID);
    result.when(
      success: (data) {
        currentRecommendations = data;
        if (recommendations.recommendations == null) {
          recommendations = currentRecommendations;
        } else {
          recommendations.recommendations?.addAll(currentRecommendations.recommendations!);
        }
      },
      error: (message) {},
    );
  }

  void setLoading({required bool value}) {
    isLoading = value;
    update();
  }

  Future<void> loadUser() async {
    //setLoading(value: true);
    final result = await profileViewRepository.getUserById(id: userID);
    await getFollow();
    //setLoading(value: false);
    result.when(
      success: (data) {
        user = data;
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
  }

  Future<FollowsModel?> getFollow() async {
    followed = homeController.follows.firstWhereOrNull((element) => element.followedId == userID);

    return followed;
  }

  Future<void> handleFollow() async {
    //setFollowing(true);

    await homeController.handleFollow(follow: followed, user: user);
    await getFollow();

    update();

    //setFollowing(true);
  }

  void loadMoreRecommendations() {
    pagination = pagination + 10;
    loadRecommendations(canLoad: false);
  }
}
