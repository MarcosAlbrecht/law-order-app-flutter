import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/home/controller/home_controller.dart';
import 'package:app_law_order/src/pages/home/view/components/filter_dialog.dart';
import 'package:app_law_order/src/pages/home/view/components/provider_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          color: CustomColors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Busque por profissionais na Prestadio. Utilize os filtros para encontrar o profissional mais próximo de você 😁",
                  textAlign: TextAlign.left,
                ),
                const Divider(
                  height: 35,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<HomeController>(
                        builder: (controller) {
                          return Expanded(
                            child: CustomTextField(
                              icon: Icons.search,
                              label: "Nome, área de atuação ou serviço ofertado",
                              onChanged: (value) {
                                controller.searchRequest.value = value!.toLowerCase();
                              },
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, left: 5),
                        child: SizedBox(
                          width: 70,
                          height: double.infinity,
                          child: Material(
                            elevation: 3,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const FilterDialog();
                                  },
                                );
                              },
                              icon: const Icon(Icons.filter_list),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                Expanded(
                  child: GetBuilder<HomeController>(
                    builder: (controller) {
                      return ListView.builder(
                        //padding: const EdgeInsets.fromLTRB(10, 10, 16, 10),
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.allUsers.length,
                        itemBuilder: (_, index) {
                          if (((index + 1) == controller.allUsers.length) && (!controller.isLastPage)) {
                            controller.loadMoreProducts();
                          }

                          return ProviderTile(
                            //height: 100,
                            //child: Text("OLA" + index.toString()),

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
