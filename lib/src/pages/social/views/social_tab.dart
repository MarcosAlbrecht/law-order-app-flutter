import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/social/controller/post_controller.dart';
import 'package:app_law_order/src/pages/social/views/components/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SocialTab extends StatefulWidget {
  const SocialTab({super.key});

  @override
  State<SocialTab> createState() => _SocialTabState();
}

class _SocialTabState extends State<SocialTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: CustomColors.white,
            ),
            child: GetBuilder<PostController>(
              builder: (controller) {
                return controller.isLoading
                    ? Center(
                        child: LoadingAnimationWidget.discreteCircle(
                          color: CustomColors.blueDark2Color,
                          secondRingColor: CustomColors.blueDarkColor,
                          thirdRingColor: CustomColors.blueColor,
                          size: 50,
                        ),
                      )
                    : Visibility(
                        visible: controller.allPosts.isNotEmpty,
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
                              if (((index + 1) == controller.allPosts.length) && (!controller.isLastPage)) {
                                controller.loadMorePosts();
                              }

                              return PostTile(post: controller.allPosts[index]);
                            },
                            itemCount: controller.allPosts.length),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
