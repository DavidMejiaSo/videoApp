import 'package:flutter/material.dart';
import 'package:video_app/design_tools/tool_widgets/app_colors.dart';
import 'package:video_player/video_player.dart';

import '../infrastructure/entities/Video.dart';

class VideoPostWidget extends StatefulWidget {
  final Video video;

  VideoPostWidget({required this.video});

  @override
  _VideoPostWidgetState createState() => _VideoPostWidgetState();
}

class _VideoPostWidgetState extends State<VideoPostWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    String urlString = widget.video.videoLink;
    Uri uri = Uri.parse(urlString);

    super.initState();
    _controller = VideoPlayerController.contentUri(uri)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _isPlaying = true;
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey.withOpacity(0.2),
      child: Column(
        children: [
          // User info
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.video
                  .ownerId), // Asumiendo que ownerId es un enlace a la foto del usuario
            ),
            title: Text(widget.video.ownerName),
            subtitle: Text(widget.video.date),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
          // Video
          GestureDetector(
            onTap: _togglePlayPause,
            child: AspectRatio(
              aspectRatio: _controller.value.isInitialized
                  ? _controller.value.aspectRatio
                  : 16 / 9,
              child: _controller.value.isInitialized
                  ? VideoPlayer(_controller)
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
          // Interaction icons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                Text('${widget.video.like} likes'),
                SizedBox(width: 16.0),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.video.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Divider
          const Divider(
            thickness: 5,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
