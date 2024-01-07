import 'package:app_law_order/src/models/order_service_model.dart';
import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile_view/controller/profile_view_controller.dart';
import 'package:app_law_order/src/pages/profile_view/repository/profile_view_repository.dart';
import 'package:get/get.dart';

class ServiceRequestController extends GetxController {
  final rofileViewRepository = ProfileViewRepository();

  final profileController = Get.find<ProfileViewController>();

  List<ServiceModel> services = [];
  final orderService = OrderServiceModel();

  bool isLoading = false;
  bool isSaving = false;

  @override
  void onInit() {
    super.onInit();

    loadServices();
  }

  void setLoading({required bool value}) {
    isLoading = value;
    update();
  }

  Future<void> loadServices() async {
    setLoading(value: true);
    if (profileController.user.services != null) {
      services = profileController.user.services!;
    }

    setLoading(value: false);
  }

  Future<void> handleService({required ServiceModel service}) async {
    if (service.isChecked!) {}
  }

  Future<void> handleCheckBox(
      {required ServiceModel service, required bool value}) async {
    setLoading(value: true);
    for (var serv in services) {
      if (serv.id == service.id) {
        serv.isChecked = value;
      }
    }

    if (value) {
      orderService.service?.add(service);
      orderService.total = (orderService.total! + service.value!);
    } else {
      orderService.service?.removeWhere((element) => element.id == service.id);
      orderService.total = (orderService.total! - service.value!);
    }

    setLoading(value: false);
  }

  bool isChecked({required ServiceModel service}) {
    final result = services.firstWhere((element) => element.id == service.id);
    return result.isChecked!;
  }
}
