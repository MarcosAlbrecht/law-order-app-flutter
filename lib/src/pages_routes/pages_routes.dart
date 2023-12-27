import 'package:app_law_order/src/pages/auth/view/sign_in_screen.dart';
import 'package:app_law_order/src/pages/auth/view/sign_up.dart';
import 'package:app_law_order/src/pages/auth/view/sign_up_step1.dart';
import 'package:app_law_order/src/pages/base/base_screen.dart';
import 'package:app_law_order/src/pages/base/binding/navigation_binding.dart';
import 'package:app_law_order/src/pages/home/binding/home_binding.dart';
import 'package:app_law_order/src/pages/home/controller/home_controller.dart';
import 'package:app_law_order/src/pages/profile/binding/profile_binding.dart';
import 'package:app_law_order/src/pages/profile/view/components/profile_screen.dart';
import 'package:app_law_order/src/pages/profile/view/profile_tab.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.signInRoute,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: PagesRoutes.signUpStep1,
      page: () => const SignUpStep1Screen(),
    ),
    GetPage(
      name: PagesRoutes.signUp,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: PagesRoutes.profileTab,
      page: () => const ProfileTab(),
    ),
    GetPage(
      name: PagesRoutes.profileScreen,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        ProfileBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String baseRoute = '/';
  static const String signInRoute = '/signin';
  static const String signUpStep1 = '/signupstep1';
  static const String signUp = '/signup';
  static const String profileTab = '/profileTab';
  static const String profileScreen = '/profileScreen';
}
