import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class NavigationTabs {
  static const int home = 0;
  static const int request = 1;
  static const int chat = 2;
  static const int perfil = 3;
  static const int socialTab = 4;
}

class NavigationController extends GetxController {
  late PageController _pageController;
  late RxInt _currentIndex;

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;

  @override
  void onInit() {
    super.onInit();
    _initNavigation(
      pageController: PageController(initialPage: NavigationTabs.home),
      currentIndex: NavigationTabs.home,
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print('Fechou');
  }

  void _initNavigation({required PageController pageController, required int currentIndex}) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  void navigatePageView(int page) {
    if (_currentIndex.value == page) {
      return;
    }

    _pageController.jumpToPage(page);
    _currentIndex.value = page;
  }
}
