import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../infrastructure/entities/Video.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../infrastructure/entities/Video.dart';

class VideoThumbnail extends StatefulWidget {
  final Video video;

  VideoThumbnail({required this.video});

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    String urlString = widget.video.videoLink;
    Uri uri = Uri.parse(urlString);

    _controller = VideoPlayerController.networkUrl(uri)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      }).catchError((error) {
        print("Error initializing video player: $error");
      });

    _controller.addListener(() {
      if (_controller.value.hasError) {
        print("Video player error: ${_controller.value.errorDescription}");
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.9,
      child: _isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
