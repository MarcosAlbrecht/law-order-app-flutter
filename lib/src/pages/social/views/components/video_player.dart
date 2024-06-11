import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
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
    final size = MediaQuery.of(context).size;
    return _isInitialized
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
