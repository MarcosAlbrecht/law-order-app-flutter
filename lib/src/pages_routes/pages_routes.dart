import 'package:app_law_order/src/pages/auth/view/sign_in_screen.dart';
import 'package:app_law_order/src/pages/auth/view/sign_up.dart';
import 'package:app_law_order/src/pages/auth/view/sign_up_step1.dart';
import 'package:app_law_order/src/pages/base/base_screen.dart';
import 'package:app_law_order/src/pages/base/binding/navigation_binding.dart';
import 'package:app_law_order/src/pages/home/binding/home_binding.dart';
import 'package:app_law_order/src/pages/profile/binding/follower_binding.dart';
import 'package:app_law_order/src/pages/profile/binding/follows_binding.dart';
import 'package:app_law_order/src/pages/profile/binding/profile_binding.dart';
import 'package:app_law_order/src/pages/profile/view/followers_screen.dart';
import 'package:app_law_order/src/pages/profile/view/follows_screen.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:app_law_order/src/pages/profile/view/profile_screen.dart';
import 'package:app_law_order/src/pages/profile/view/profile_tab.dart';
import 'package:app_law_order/src/pages/profile_view/binding/profile_view_binding.dart';
import 'package:app_law_order/src/pages/profile_view/binding/service_request_binding.dart';
import 'package:app_law_order/src/pages/profile_view/view/profile_view_screen.dart';
import 'package:app_law_order/src/pages/profile_view/view/service_request_screen.dart';
import 'package:app_law_order/src/pages/requests/binding/request_binding.dart';
import 'package:app_law_order/src/pages/requests/view/request_detail_screen.dart';
import 'package:app_law_order/src/pages/requests/view/request_tab.dart';
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
      name: PagesRoutes.requestTab,
      page: () => const RequestTab(),
    ),
    GetPage(
      name: PagesRoutes.portfolioScreen,
      page: () => const PortfolioScreen(),
    ),
    GetPage(
      name: PagesRoutes.followsScreen,
      page: () => const FollowsScreen(),
      binding: FollowsBinding(),
    ),
    GetPage(
      name: PagesRoutes.followerScreen,
      page: () => const FollowerScreen(),
      binding: FollowerBinding(),
    ),
    GetPage(
      name: PagesRoutes.profileViewScreen,
      page: () => const ProfileViewScreen(),
      binding: ProfileViewBinding(),
    ),
    GetPage(
      name: PagesRoutes.serviceRequestScreen,
      page: () => ServiceRequestScreen(),
      binding: ServiceRequestBinding(),
    ),
    GetPage(
      name: PagesRoutes.requestDetailScreen,
      page: () => RequestDetailScreen(),
      //binding: ServiceRequestBinding(),
    ),
    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        ProfileBinding(),
        RequestBinding(),
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
  static const String portfolioScreen = '/portfolioScreen';
  static const String followsScreen = '/followsScreen';
  static const String followerScreen = '/followerScreen';
  static const String profileViewScreen = '/profileViewScreen';
  static const String serviceRequestScreen = '/serviceRequestScreen';
  static const String requestTab = '/requestTab';
  static const String requestDetailScreen = '/requestDetailScreen';
}
