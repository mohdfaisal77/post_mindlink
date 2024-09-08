import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPostWidget extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;

  const VideoPostWidget({super.key, required this.videoUrl, required this.thumbnailUrl});

  @override
  _VideoPostWidgetState createState() => _VideoPostWidgetState();
}

class _VideoPostWidgetState extends State<VideoPostWidget> {
  late VideoPlayerController _controller;
  bool _isVideoPlaying = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isLoading = false;  // Video is ready
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;  // Handle video loading errors
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_isLoading)
          const CircularProgressIndicator(),
        if (_controller.value.isInitialized)
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        if (!_controller.value.isPlaying && !_isLoading)
          IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.white, size: 50),
            onPressed: () {
              setState(() {
                _isVideoPlaying = true;
                _controller.play();
              });
            },
          ),
        if (_controller.value.isPlaying)
          IconButton(
            icon: const Icon(Icons.pause, color: Colors.white, size: 50),
            onPressed: () {
              setState(() {
                _controller.pause();
              });
            },
          ),
      ],
    );
  }
}
