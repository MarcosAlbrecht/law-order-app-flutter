import 'package:app_law_order/src/models/pix_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/models/wallet_model.dart';
import 'package:app_law_order/src/models/withdraw_history_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile/repository/profile_repository.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:get/get.dart';

class WithDrawController extends GetxController {
  final profileRepository = ProfileRepository();
  final authController = Get.find<AuthController>();
  late String selectedUserId;
  UserModel user = UserModel();
  WalletModel wallet = WalletModel();
  List<WithdrawHistoryModel> withdraws = [];

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
      loadWithdraw(),
      loadUser(),
      loadWallet(),

      // Adicione mais chamadas conforme necessário
    ];

    // Aguarda todas as chamadas assíncronas serem concluídas
    await Future.wait(futures);

    setLoading(false);
  }

  Future<void> loadWithdraw() async {
    final result = await profileRepository.getWithdraws();
    result.when(success: (data) {
      withdraws = data;
    }, error: (message) {
      utilServices.showToast(message: message, isError: true);
    });
  }

  Future<void> loadWallet() async {
    final result = await profileRepository.getWallet();
    result.when(success: (data) {
      wallet = data;
    }, error: (message) {
      utilServices.showToast(message: message, isError: true);
    });
  }

  Future<void> loadUser({bool canload = false}) async {
    if (canload) {
      setLoading(true);
    }
    final result = await profileRepository.getUserById(id: selectedUserId);

    setLoading(false);

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
    user.pix![position].active = false;
    //altera o selecionado para true
    user.pix![index].active = true;
    user.pix;
    update();
  }

  void handleShowClosePixDialog(String status) {
    if (status == 'canceled') {
      loadUser(canload: false);
    } else if (status == 'show') {}
    //update();
  }

  Future<void> handleUpdatePix() async {
    setLoading(true);
    final PixModel? pixModel = user.pix!.firstWhereOrNull((e) => e.active == true);
    if (pixModel != null) {
      final result = await profileRepository.updateActivePix(key: pixModel.key!);
      result.when(
        success: (message) {
          utilServices.showToast(message: message);
        },
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
          user.pix!.forEach(
            (element) {
              element.active = false;
            },
          );
          user.pix!.add(pixModel);
          utilServices.showToast(message: 'Chave Pix cadastrada com sucesso');
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
        user.pix!.removeWhere((element) => element.key == key);
        if (user.pix!.length <= 1) {
          user.pix![0].active = true;
        }
        utilServices.showToast(message: 'Chave Pix removida com sucesso');
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
    setLoadingPix(false);
  }
}
