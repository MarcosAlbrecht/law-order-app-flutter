import 'package:app_law_order/src/constants/constants.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/profile/repository/profile_repository.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class ConfigurationsController extends GetxController {
  final profileRepository = ProfileRepository();

  final authController = Get.find<AuthController>();

  late String tokenOneSignal;

  bool isSaving = false;
  bool isLoading = true;

  @override
  void onInit() {
    tokenOneSignal = authController.user.tokenOneSignal ?? '';
    initOneSignal();
    super.onInit();
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> initOneSignal() async {
    print("INICIOU ONESIGNAL");
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    OneSignal.consentRequired(false);

    OneSignal.initialize(Constants.oneSignalAppID);

    OneSignal.Notifications.clearAll();

    if (GetPlatform.isIOS) {
      OneSignal.Notifications.requestPermission(true);
    }

    OneSignal.User.pushSubscription.addObserver((state) {
      if (OneSignal.User.pushSubscription.id!.isNotEmpty) {
        tokenOneSignal = OneSignal.User.pushSubscription.id!;
      }
      //print("ENTROU NO OBSERVER: " + tokenOneSignal);
    });
  }

  Future<void> getTokenOneSignal() async {
    //print("ENTROU NO GET TOKEN: ");

    await OneSignal.User.pushSubscription.optIn();

    tokenOneSignal = OneSignal.User.pushSubscription.id.toString();

    print(tokenOneSignal);
    //handleChangeTokenOneSignal();
  }

  Future<void> handleChangeTokenOneSignal() async {
    setLoading(true);
    if (authController.user.tokenOneSignal == null || authController.user.tokenOneSignal!.isEmpty) {
      await getTokenOneSignal();
    } else {
      tokenOneSignal = '';
    }
    final result = await profileRepository.updateTokenOneSignal(user: authController.user, token: tokenOneSignal);
    setLoading(false);
    result.when(
      success: (data) {
        authController.user.tokenOneSignal = tokenOneSignal;
      },
      error: (message) {},
    );
  }
}
