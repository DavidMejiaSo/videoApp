import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_app/src/providers/favourites_user_provider.dart';
import 'package:video_player/video_player.dart';

import '../infrastructure/entities/Video.dart';

class VideoPostWidget extends ConsumerStatefulWidget {
  final Video video;

  VideoPostWidget({required this.video});

  @override
  ConsumerState createState() => _VideoPostWidgetState();
}

class _VideoPostWidgetState extends ConsumerState<VideoPostWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  String _formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString);
    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return "${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}";
  }

  @override
  void initState() {
    super.initState();

    String urlString = widget.video.videoLink;
    Uri uri = Uri.parse(urlString);

    _controller = VideoPlayerController.networkUrl(uri)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _isPlaying = true;
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
    final favouriteState = ref.read(favouriteProvider.notifier);
    final favourite = ref.watch(favouriteProvider).favourites;
    final isFavourite = favourite.contains(widget.video.id);
    final likes = isFavourite ? widget.video.like + 1 : widget.video.like;

    return Stack(
      children: [
        Container(
          color: Colors.black,
          child: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              GoRouter.of(context).go('/profilePage');
              // Acción para ir al perfil del usuario
            },
          ),
        ),
        Positioned(
          bottom: 100,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.video.ownerId),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.video.ownerName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formatDate(widget.video.date),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.video.description,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onDoubleTap: () async {
                  setState(() {
                    if (isFavourite) {
                      favouriteState.unlike(widget.video.id);
                    } else {
                      favouriteState.addlike(widget.video.id);
                    }
                  });
                },
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white),
                      onPressed: () {
                        setState(() {
                          if (isFavourite) {
                            favouriteState.unlike(widget.video.id);
                          } else {
                            favouriteState.addlike(widget.video.id);
                          }
                        });
                      },
                    ),
                    Text(
                      '${likes} likes',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 16.0),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
