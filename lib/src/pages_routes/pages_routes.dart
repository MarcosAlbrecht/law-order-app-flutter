import 'package:app_law_order/src/global/binding/global_binding.dart';
import 'package:app_law_order/src/pages/auth/view/sign_in_screen.dart';
import 'package:app_law_order/src/pages/auth/view/sign_up.dart';
import 'package:app_law_order/src/pages/auth/view/sign_up_google.dart';
import 'package:app_law_order/src/pages/auth/view/sign_up_step1.dart';
import 'package:app_law_order/src/pages/base/base_screen.dart';
import 'package:app_law_order/src/pages/base/binding/navigation_binding.dart';
import 'package:app_law_order/src/pages/chat/binding/chat_binding.dart';
import 'package:app_law_order/src/pages/chat/binding/wallet_payments_binding.dart';
import 'package:app_law_order/src/pages/chat/view/chat_list_tab.dart';
import 'package:app_law_order/src/pages/chat/view/chat_messages_screen.dart';
import 'package:app_law_order/src/pages/chat/view/payments_wallet_screen.dart';
import 'package:app_law_order/src/pages/home/binding/home_binding.dart';
import 'package:app_law_order/src/pages/profile/binding/configurations_binding.dart';
import 'package:app_law_order/src/pages/profile/binding/follower_binding.dart';
import 'package:app_law_order/src/pages/profile/binding/follows_binding.dart';
import 'package:app_law_order/src/pages/profile/binding/my_wallet_binding.dart';
import 'package:app_law_order/src/pages/profile/binding/notification_binding.dart';
import 'package:app_law_order/src/pages/profile/binding/profile_binding.dart';
import 'package:app_law_order/src/pages/profile/binding/withdraw_binding.dart';
import 'package:app_law_order/src/pages/profile/view/configurations_screen.dart';
import 'package:app_law_order/src/pages/profile/view/followers_screen.dart';
import 'package:app_law_order/src/pages/profile/view/follows_screen.dart';
import 'package:app_law_order/src/pages/profile/view/my_wallet_screen.dart';
import 'package:app_law_order/src/pages/profile/view/notifications_screen.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:app_law_order/src/pages/profile/view/profile_screen.dart';
import 'package:app_law_order/src/pages/profile/view/profile_tab.dart';
import 'package:app_law_order/src/pages/profile/view/withdraw_screen.dart';
import 'package:app_law_order/src/pages/profile_view/binding/profile_view_binding.dart';
import 'package:app_law_order/src/pages/profile_view/binding/service_request_binding.dart';
import 'package:app_law_order/src/pages/profile_view/view/profile_view_screen.dart';
import 'package:app_law_order/src/pages/profile_view/view/service_request_screen.dart';
import 'package:app_law_order/src/pages/requests/binding/request_binding.dart';
import 'package:app_law_order/src/pages/requests/binding/request_manager_binding.dart';
import 'package:app_law_order/src/pages/requests/view/avaliation_screen.dart';
import 'package:app_law_order/src/pages/requests/view/request_manager_screen.dart';
import 'package:app_law_order/src/pages/requests/view/request_tab.dart';
import 'package:app_law_order/src/pages/social/binding/post_binding.dart';
import 'package:app_law_order/src/pages/social/views/post_screen.dart';
import 'package:app_law_order/src/pages/social/views/social_tab.dart';
import 'package:app_law_order/src/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => const SplashScreen(),
      name: PagesRoutes.splashRoute,
    ),
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
      name: PagesRoutes.signupGoogleRoute,
      page: () => SignupGoogleScreen(),
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
      name: PagesRoutes.avaliationScreen,
      page: () => AvaliationScreen(),
    ),
    GetPage(
      name: PagesRoutes.paymentosWalletRoute,
      page: () => const PaymentsWalletScreen(),
      binding: PaymentsWalletBinding(),
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
      name: PagesRoutes.notificationsScreen,
      page: () => const NotificationsScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: PagesRoutes.requestManagerScreen,
      page: () => const RequestManagerScreen(),
      binding: RequestManagerBinding(),
    ),
    GetPage(
      name: PagesRoutes.withdrawScreen,
      page: () => WithdrawScreen(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: PagesRoutes.mayWalletScreen,
      page: () => MyWalletScreen(),
      binding: MyWalletBinding(),
    ),
    GetPage(
      name: PagesRoutes.configurationsScreen,
      page: () => ConfigurationsScreen(),
      binding: ConfigurationsBinding(),
    ),
    GetPage(
      name: PagesRoutes.socialTab,
      page: () => SocialTab(),
      //binding: PostBinding(),
    ),
    GetPage(
      name: PagesRoutes.postScreen,
      page: () => PostScreen(),
      //binding: PostBinding(),
    ),
    GetPage(
      name: PagesRoutes.chatListTab,
      page: () => const ChatListTab(),
    ),
    GetPage(
      name: PagesRoutes.chatMessageScreen,
      page: () => ChatMessageScreen(),
    ),
    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        ProfileBinding(),
        RequestBinding(),
        ChatBinding(),
        GlobalBinding(),
        PostBinding()
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
  static const String requestManagerScreen = '/requestManagerScreen';
  static const String notificationsScreen = '/notificationsScreen';
  static const String avaliationScreen = '/avaliationScreen';
  static const String chatListTab = '/chatListTabScreen';
  static const String chatMessageScreen = '/chatMessageScreen';
  static const String withdrawScreen = '/withdrawScreen';
  static const String mayWalletScreen = '/mayWalletScreen';
  static const String splashRoute = '/splashRoute';
  static const String configurationsScreen = '/configurationsScreen';
  static const String signupGoogleRoute = '/signupGoogleRoute';
  static const String paymentosWalletRoute = '/paymentosWalletRoute';
  static const String socialTab = '/socialTab';
  static const String postScreen = '/postTab';
}
