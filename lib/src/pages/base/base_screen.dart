import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/base/controller/navigation_controller.dart';
import 'package:app_law_order/src/pages/home/view/home_tab.dart';
import 'package:app_law_order/src/pages/profile/view/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.pageController,
        children: const [
          HomeTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            navigationController.navigatePageView(index);
          },
          currentIndex: navigationController.currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: CustomColors.blueDarkColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.cyan.shade700,
          items: [
            BottomNavigationBarItem(
              icon: navigationController.currentIndex != 0
                  ? const Icon(Icons.home_outlined)
                  : const Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: navigationController.currentIndex != 1
                  ? const Icon(Icons.person_2_outlined)
                  : const Icon(Icons.person_2),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
