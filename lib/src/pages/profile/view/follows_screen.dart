import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/profile/controller/follows_controller.dart';
import 'package:app_law_order/src/pages/profile/view/components/follows_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowsScreen extends StatelessWidget {
  const FollowsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Seguindo",
          style: TextStyle(color: CustomColors.black),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: CustomColors.white,
          ),
          child: GetBuilder<FollowsController>(
            builder: (controller) {
              return controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Visibility(
                      visible: controller.follows.isNotEmpty,
                      replacement: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              color: CustomColors.blueDarkColor,
                            ),
                            const Text('Não há itens para apresentar'),
                          ],
                        ),
                      ),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          if (((index + 1) == controller.follows.length) &&
                              (!controller.isLastPage)) {
                            controller.loadMoreFollows();
                          }

                          return FollowsTile(
                            //height: 100,
                            //child: Text("OLA" + index.toString()),

                            follow: controller.follows[index],
                          );
                        },
                        itemCount: controller.follows.length,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
