import 'dart:io';

import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/social/controller/post_controller.dart';
import 'package:app_law_order/src/pages/social/views/components/post_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

final List<int> _items = List<int>.generate(50, (int index) => index);

class _PostScreenState extends State<PostScreen> {
  final authController = Get.find<AuthController>();
  List array = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  final List<int> _items = List<int>.generate(50, (int index) => index);
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: GetBuilder<PostController>(
            builder: (controller) {
              return Column(
                children: [
                  // App bar and text form field
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          PostCustomAppBar(
                            logedUserId: authController.user.id!,
                            user: authController.user,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              minLines: 8,
                              maxLines: 15,
                              style: const TextStyle(fontSize: 18),
                              decoration: const InputDecoration(
                                hintText: "Compartilhe suas ideias...",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.4, // Example height to see the effect
                            //color: Colors.red,
                            child: ReorderableListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              itemCount: controller.files.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  key: Key('$index'),
                                  height: 100,
                                  width: size.width * .7,
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 4,
                                        ),
                                      ]),
                                  child: Center(
                                    child: Image.file(
                                      File(controller.files[index].path),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                              onReorder: (int oldIndex, int newIndex) {
                                setState(() {
                                  if (oldIndex < newIndex) {
                                    newIndex -= 1;
                                  }
                                  final File item = controller.files.removeAt(oldIndex);
                                  controller.files.insert(newIndex, item);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Fixed height container at the bottom
                  Container(
                    height: 50,
                    //color: Colors.green,
                    width: size.width,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            controller.imagePicker();
                          },
                          icon: const Icon(
                            Icons.photo,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
