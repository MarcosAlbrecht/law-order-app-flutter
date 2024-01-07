import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile_view/repository/profile_view_repository.dart';
import 'package:get/get.dart';

class ServiceRequestController extends GetxController {
  final rofileViewRepository = ProfileViewRepository();

  final authController = AuthController();

  List<ServiceModel> service = [];

  bool isLoading = false;
  bool isSaving = false;

  @override
  void onInit() {
    super.onInit();

    loadServices();
  }

  Future<void> loadServices() async {
    if (authController.user.services != null) {
      service = authController.user.services!;
    }
  }
}
