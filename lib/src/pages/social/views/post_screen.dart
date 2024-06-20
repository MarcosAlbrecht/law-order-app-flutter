import 'dart:io';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/social/controller/post_controller.dart';
import 'package:app_law_order/src/pages/social/views/components/post_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:video_player/video_player.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final authController = Get.find<AuthController>();

  final messageEC = TextEditingController();

  void clearText() {
    messageEC.clear();
  }

  Widget buildItem(String path, PostController controller, {bool fromServer = false}) {
    final isVideo = _isVideoFile(path);
    return Stack(
      key: ValueKey(path),
      children: [
        Card(
          child: isVideo
              ? VideoItem(filePath: path)
              : !fromServer
                  ? Image.file(
                      File(path),
                      fit: BoxFit.cover,
                      height: 200,
                      width: MediaQuery.of(context).size.width * .7,
                      cacheHeight: 600,
                      cacheWidth: 600,
                    )
                  : Image.network(
                      path,
                      fit: BoxFit.cover,
                      height: 200,
                      width: MediaQuery.of(context).size.width * .7,
                      cacheHeight: 600,
                      cacheWidth: 600,
                    ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              controller.removeFile(filePath: path);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _isVideoFile(String path) {
    final videoExtensions = ['mp4', 'mov', 'wmv', 'avi', 'mkv'];
    final fileExtension = path.split('.').last.toLowerCase();
    return videoExtensions.contains(fileExtension);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<PostController>(
          builder: (controller) {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            PostCustomAppBar(
                              controller: controller,
                              logedUserId: authController.user.id!,
                              user: authController.user,
                              onPostPressed: () async {
                                await controller.handleEditInsertPost();
                                Get.back();
                              },
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextFormField(
                                initialValue: controller.descricaoPost,
                                //controller: messageEC,
                                minLines: 3,
                                maxLines: 10,
                                style: const TextStyle(fontSize: 18),
                                decoration: const InputDecoration(
                                  hintText: "Compartilhe suas ideias...",
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  // setState(() {
                                  //   messageEC.text = value;
                                  // });
                                  controller.descricaoPost = value;
                                },
                              ),
                            ),
                            controller.isLoadingFiles
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: CustomColors.blueDark2Color,
                                    ),
                                  )
                                : SizedBox(
                                    height: size.height * .5,
                                    child: Center(
                                      child: ReorderableGridView.count(
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 2,
                                        onReorder: (oldIndex, newIndex) {
                                          setState(() {
                                            final element = controller.files.removeAt(oldIndex);
                                            controller.files.insert(newIndex, element);
                                          });
                                        },
                                        children: controller.files
                                            .map(
                                              (e) => buildItem(
                                                e.localPath ?? e.url!,
                                                controller,
                                                fromServer: e.url != null,
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          heroTag: null,
                          foregroundColor: Colors.white,
                          backgroundColor: CustomColors.blueDarkColor,
                          onPressed: () {
                            controller.videoPicker();
                          },
                          child: const Icon(Icons.video_library),
                        ),
                        const SizedBox(width: 16),
                        FloatingActionButton(
                          heroTag: null,
                          foregroundColor: Colors.white,
                          backgroundColor: CustomColors.blueDarkColor,
                          onPressed: () {
                            controller.imagePicker();
                          },
                          child: const Icon(Icons.image),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class VideoItem extends StatefulWidget {
  final String filePath;

  const VideoItem({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
        ? GestureDetector(
            onTap: () {
              setState(() {
                _controller.value.isPlaying ? _controller.pause() : _controller.play();
              });
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _ControlsOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
          child: Center(
            child: AnimatedOpacity(
              opacity: controller.value.isPlaying ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.black26),
                child: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 100.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
