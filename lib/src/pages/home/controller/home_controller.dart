import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/home/repository/home_repository.dart';
import 'package:get/get.dart';

const int itemsPerPage = 10;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();

  List<UserModel>? currentListUser;

  List<UserModel> allUsers = [];

  int pagination = 0;

  bool get isLastPage {
    if (currentListUser!.length < itemsPerPage) return true;

    return pagination * itemsPerPage > allUsers.length;
  }

  @override
  void onInit() {
    super.onInit();

    loadAllUsers();
  }

  bool isUserLoading = false;

  void setLoading(bool value, {bool isUser = false}) {
    if (isUser) {
      isUserLoading = value;
    }
    update();
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
      error: (message) {},
    );
  }

  void loadMoreProducts() {
    pagination = pagination + 10;
    loadAllUsers(canLoad: false);
  }
}
