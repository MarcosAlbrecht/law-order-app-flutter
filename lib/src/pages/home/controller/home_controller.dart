import 'package:app_law_order/src/models/follows_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/home/repository/home_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';

const int itemsPerPage = 10;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();

  final utilServices = UtilServices();

  final authController = Get.find<AuthController>();

  List<UserModel>? currentListUser;

  List<UserModel> allUsers = [];
  List<FollowsModel> follows = [];

  int pagination = 0;

  bool get isLastPage {
    if (currentListUser!.length < itemsPerPage) return true;

    return pagination * itemsPerPage > allUsers.length;
  }

  @override
  void onInit() {
    super.onInit();

    //loadAllUsers();
    loadDatas();
  }

  bool isUserLoading = false;

  void setLoading(bool value, {bool isUser = false}) {
    if (isUser) {
      isUserLoading = value;
    }
    update();
  }

  Future<void> loadDatas() async {
    setLoading(true, isUser: true);
    List<Future<void>> operations = [
      loadAllUsers(),
      loadFollows(),
    ];

    await Future.wait(operations);

    setLoading(false, isUser: true);
  }

  Future<void> loadFollows() async {
    var result = await homeRepository.getFollows();

    result.when(
      success: (data) {
        follows.addAll(data);
      },
      error: (message) {},
    );
  }

  Future<void> loadAllUsers({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isUser: true);
    }

    var result = await homeRepository.getAllUsersPaginated(
        limit: itemsPerPage, skip: pagination);

    setLoading(false, isUser: true);

    result.when(
      success: (data) {
        currentListUser = data;
        allUsers.addAll(currentListUser!);
      },
      error: (message) {
        utilServices.showToast(message: message);
      },
    );
  }

  void loadMoreProducts() {
    pagination = pagination + 10;
    loadAllUsers(canLoad: false);
  }
}
