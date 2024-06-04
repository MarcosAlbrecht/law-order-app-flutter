import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/home/controller/home_controller.dart';
import 'package:app_law_order/src/pages/social/controller/post_controller.dart';
import 'package:app_law_order/src/pages/social/views/components/post_tile.dart';
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
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: const Text('Home'),
                //selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  //_onItemTapped(0);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Business'),
                //selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                  //_onItemTapped(1);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('School'),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                  //_onItemTapped(2);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            color: CustomColors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
                        GetBuilder<HomeController>(
                          builder: (controller) {
                            return Expanded(
                              child: CustomTextField(
                                label: 'No que você está pensando?',
                                removeFloatingLabelBehavior: true,
                                minLines: 1,
                                maxLines: 3,
                                paddingBottom: false,
                                onChanged: (value) {
                                  controller.searchRequest.value = value!.toLowerCase();
                                },
                              ),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () {},
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

                            return PostTile(post: controller.allPosts[index]);
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
    );
  }
}
