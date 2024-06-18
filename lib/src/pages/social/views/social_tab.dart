import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/social/controller/post_controller.dart';
import 'package:app_law_order/src/pages/social/views/components/post_tile.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:get/get.dart';

class SocialTab extends StatefulWidget {
  const SocialTab({Key? key}) : super(key: key);

  @override
  _SocialTabState createState() => _SocialTabState();
}

class _SocialTabState extends State<SocialTab> {
  late final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                color: CustomColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      const Divider(
                        height: 10,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GetBuilder<PostController>(
                              builder: (controller) {
                                return Expanded(
                                  child: CustomTextField(
                                    label: 'No que você está pensando?',
                                    removeFloatingLabelBehavior: true,
                                    minLines: 1,
                                    maxLines: 3,
                                    paddingBottom: false,
                                    onChanged: (value) {
                                      Get.toNamed(
                                        PagesRoutes.postScreen,
                                        //arguments: {'chat_model': chat},
                                      );
                                      //controller.searchRequest.value = value!.toLowerCase();
                                    },
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                Get.toNamed(
                                  PagesRoutes.postScreen,
                                  //arguments: {'chat_model': chat},
                                );
                              },
                              icon: const Icon(Elusive.attach),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 50,
                      ),
                      Expanded(
                        child: GetBuilder<PostController>(
                          builder: (controller) {
                            return ListView.builder(
                              //padding: const EdgeInsets.fromLTRB(10, 10, 16, 10),
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.allPosts.length,
                              itemBuilder: (_, index) {
                                if (((index + 1) == controller.allPosts.length) && (!controller.isLastPage)) {
                                  controller.loadMorePosts();
                                }

                                return PostTile(
                                  post: controller.allPosts[index],
                                  onHandleComment: () {
                                    print('chegou no call back social tab');
                                  },
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
          ),
        ],
      ),
    );
  }
}
