import 'package:app_law_order/src/models/order_service_model.dart';
import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:app_law_order/src/pages/profile_view/controller/profile_view_controller.dart';
import 'package:app_law_order/src/pages/profile_view/repository/profile_view_repository.dart';
import 'package:app_law_order/src/pages/profile_view/view/components/services_request_tile.dart';
import 'package:get/get.dart';

class ServiceRequestController extends GetxController {
  final profileViewRepository = ProfileViewRepository();

  final profileController = Get.find<ProfileViewController>();

  List<ServiceModel> services = [];
  final orderService = OrderServiceModel();

  bool isLoading = false;
  bool isSaving = false;

  List<String> requestedServiceIds = [];

  @override
  void onInit() {
    super.onInit();

    loadServices();
  }

  void setLoading({required bool value}) {
    isLoading = value;
    update();
  }

  void setSaving({required bool value}) {
    isSaving = value;
    update();
  }

  Future<void> loadServices() async {
    setLoading(value: true);
    if (profileController.user.services != null) {
      services = profileController.user.services!;
      unCheckServices();
    }

    setLoading(value: false);
  }

  void unCheckServices() {
    for (var serv in services) {
      serv.isChecked = false;
    }
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

  Future<void> handleServiceRequest() async {
    setSaving(value: true);
    if (services.isEmpty) {
      utilServices.showToast(
        message: "Prestador ainda não possui serviços cadastrado(s).",
      );
      setSaving(value: false);
      return;
    }

    requestedServiceIds = [];

    if (verifyServicesChecked() > 0) {
      final result = await profileViewRepository.insertServiceRequest(
          userRequestedId: profileController.user.id!,
          requestedServiceIds: requestedServiceIds);

      result.when(
        success: (data) {
          utilServices.showToast(message: "Solicitação enviada com sucesso!");
          Get.back();
        },
        error: (message) {
          utilServices.showToast(message: message, isError: true);
        },
      );
    } else {
      utilServices.showToast(
        message: "Selecione o(s) serviços(s) que deseja solicitar",
      );
      setSaving(value: false);
      return;
    }
  }

  int verifyServicesChecked() {
    var count = 0;

    for (var service in services) {
      if (service.isChecked!) {
        requestedServiceIds.add(service.id!);
        count++;
      }
    }

    return count;
  }
}
