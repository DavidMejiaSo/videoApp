import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_app/design_tools/tool_widgets/necesary_images.dart';
import 'package:video_app/src/providers/video_provider.dart';

import '../../design_tools/tool_widgets/app_colors.dart';

import '../../widgets/video_card.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          final videosData = ref.watch(videoProvider).videos; //-->lISTADO
          return Container(
            decoration: BoxDecoration(
              color: AppColors.paleWhite.withOpacity(0.5),
              image: DecorationImage(
                opacity: 0.2,
                fit: BoxFit.cover,
                image: AssetImage(NecessaryImages.logo),
              ),
            ),
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: videosData!.length,
              itemBuilder: (context, index) {
                final video = videosData[index];
                return Stack(
                  children: [
                    // Fondo opaco del video
                    Opacity(
                      opacity: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(video.videoLink),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // VideoPostWidget
                    VideoPostWidget(video: video),
                  ],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
