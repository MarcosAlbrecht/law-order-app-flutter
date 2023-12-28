import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/home/controller/home_controller.dart';
import 'package:app_law_order/src/pages/home/view/components/provider_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.only(top: 10),
          color: CustomColors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Busque por profissionais na Prestadio. Utilize os filtros para encontrar o profissional mais próximo de você 😁",
                  textAlign: TextAlign.left,
                ),
                const Divider(
                  height: 20,
                ),
                Expanded(
                  child: GetBuilder<HomeController>(
                    builder: (controller) {
                      return ListView.builder(
                        //padding: const EdgeInsets.fromLTRB(10, 10, 16, 10),
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.allUsers.length,
                        itemBuilder: (_, index) {
                          if (((index + 1) == controller.allUsers.length) &&
                              (!controller.isLastPage)) {
                            controller.loadMoreProducts();
                          }
                          final follow = controller.follows.firstWhereOrNull(
                              (element) =>
                                  element.followedId ==
                                  controller.allUsers[index].id);
                          return ProviderTile(
                            //height: 100,
                            //child: Text("OLA" + index.toString()),
                            follow: follow,
                            item: controller.allUsers[index],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
