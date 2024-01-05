import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:app_law_order/src/pages/profile_view/repository/profile_view_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';

class ProfileViewController extends GetxController {
  final profileViewRepository = ProfileViewRepository();

  final utilService = UtilServices();

  UserModel user = UserModel();

  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>;
    final String idUser = arguments['idUser'];
    loadUser(id: idUser);
  }

  void setLoading({required bool value}) {
    isLoading = value;
    update();
  }

  Future<void> loadUser({required String id}) async {
    setLoading(value: true);
    final result = await profileViewRepository.getUserById(id: id);
    setLoading(value: false);
    result.when(
      success: (data) {
        user = data;
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
  }
}
