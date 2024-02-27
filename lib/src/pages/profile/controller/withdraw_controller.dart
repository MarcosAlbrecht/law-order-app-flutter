import 'package:app_law_order/src/models/pix_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile/repository/profile_repository.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:get/get.dart';

class WithDrawController extends GetxController {
  final profileRepository = ProfileRepository();
  final authController = Get.find<AuthController>();
  late String selectedUserId;
  UserModel user = UserModel();
  List<PixModel> pixCopy = [];

  bool isSaving = false;
  bool isLoading = true;
  bool isLoadingPix = false;

  @override
  void onInit() {
    super.onInit();
    selectedUserId = authController.user.id!;
    loadDatas();
  }

  void setLoading(bool value) {
    isLoading = value;

    update();
  }

  void setLoadingPix(bool value) {
    isLoadingPix = value;
    update();
  }

  Future<void> loadDatas() async {
    setLoading(true);
    List<Future<void>> futures = [
      loadPayments(),
      loadUser(),

      // Adicione mais chamadas conforme necessário
    ];

    // Aguarda todas as chamadas assíncronas serem concluídas
    await Future.wait(futures);

    setLoading(false);
  }

  Future<void> loadPayments() async {}

  Future<void> loadUser() async {
    final result = await profileRepository.getUserById(id: selectedUserId);
    result.when(
      success: (data) {
        user = data;
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
  }

  void toggleStateItem({required int index}) {
    final int position = user.pix!.indexWhere((e) => e.active == true);
    //altera o ativo para false
    user.pix?[position].active = false;
    //altera o selecionado para true
    user.pix?[index].active = true;
    update();
  }

  void handleShowClosePixDialog(String status) {
    if (status == 'canceled') {
      user.pix = pixCopy;
    } else if (status == 'show') {
      pixCopy.clear();
      pixCopy.addAll(user.pix!);
    }
    update();
  }

  Future<void> handleUpdatePix() async {
    setLoading(true);
    final PixModel? pixModel = user.pix!.firstWhereOrNull((e) => e.active == true);
    if (pixModel != null) {
      final result = await profileRepository.updateActivePix(key: pixModel.key!);
      result.when(
        success: (data) {},
        error: (message) {
          utilServices.showToast(message: message, isError: true);
        },
      );
    }

    setLoading(false);
  }

  Future<void> handleCreatePix({required String key}) async {
    setLoading(true);
    PixModel pixModel = PixModel(active: true, key: key);

    if (pixModel != null) {
      final result = await profileRepository.createPix(key: pixModel.key!);
      result.when(
        success: (data) {
          user.pix?.forEach(
            (element) {
              element.active = false;
            },
          );
          user.pix?.add(pixModel);
        },
        error: (message) {
          utilServices.showToast(message: message, isError: true);
        },
      );
    }

    setLoading(false);
  }

  Future<void> handleDeletePix({required int index}) async {
    setLoadingPix(true);
    final String key = user.pix![index].key!;
    final result = await profileRepository.deletePix(key: key);
    result.when(
      success: (data) {
        user.pix?.removeWhere((element) => element.key == key);
        if (user.pix != null && user.pix!.length <= 1) {
          user.pix?[0].active = true;
        }
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
    setLoadingPix(false);
  }
}
