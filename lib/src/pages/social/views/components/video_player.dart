import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

class CachedVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const CachedVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _CachedVideoPlayerState createState() => _CachedVideoPlayerState();
}

class _CachedVideoPlayerState extends State<CachedVideoPlayer> with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final fileInfo = await DefaultCacheManager().getSingleFile(widget.videoUrl);
    _controller = VideoPlayerController.file(fileInfo)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _isLoading = false;
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
    super.build(context);
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _isInitialized
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: Container(
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
                ),
              )
            : Center(child: CircularProgressIndicator());
  }

  @override
  bool get wantKeepAlive => true;
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({required this.controller});

  final VideoPlayerController controller;

  @override
  _ControlsOverlayState createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
  static const List<double> _examplePlaybackRates = [0.5, 1.0, 1.5, 2.0];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.value.isPlaying ? widget.controller.pause() : widget.controller.play();
            });
          },
          child: Center(
            child: AnimatedOpacity(
              opacity: widget.controller.value.isPlaying ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.black26),
                child: Icon(
                  widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 100.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<double>(
            initialValue: widget.controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              widget.controller.setPlaybackSpeed(speed);
              setState(() {}); // Atualiza a UI
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${widget.controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}

class VideoListPage extends StatelessWidget {
  final List<String> videoUrls;

  const VideoListPage({Key? key, required this.videoUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video List")),
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return Container(
            key: PageStorageKey(index),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: CachedVideoPlayer(videoUrl: videoUrls[index]),
          );
        },
      ),
    );
  }
}
