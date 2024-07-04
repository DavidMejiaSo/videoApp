import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_app/design_tools/tool_widgets/necesary_images.dart';
import 'package:video_app/infrastructure/entities/video.dart';

import '../../design_tools/tool_widgets/app_colors.dart';

import '../../design_tools/tool_widgets/tool_widgets.dart';

import '../../widgets/video_card.dart';
import '../providers/providers_dev.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Consumer(builder: (context, ref, child) {
              final videosData = ref.watch(videosListProvider); //-->lISTADO
              return Container(
                decoration: BoxDecoration(
                    color: AppColors.paleWhite.withOpacity(0.5),
                    image: DecorationImage(
                      opacity: 0.2,
                      fit: BoxFit.contain,
                      image: AssetImage(NecessaryImages.logo),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: videosData.length,
                    itemBuilder: (context, index) {
                      final video = videosData[index];

                      return VideoPostWidget(video: video);
                    },
                  ),
                ),
              );
            }),
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: Center(child: _searchProduct()),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _searchProduct() {
    return AppWidgets.customCard(
      containerWidth: MediaQuery.of(context).size.width * 0.9,
      topRightRadius: 14,
      topLeftRadius: 14,
      bottomRightRadius: 14,
      bottomLeftRadius: 14,
      cardColor: Colors.black.withOpacity(0.2),
      margin: const EdgeInsets.only(top: 30, bottom: 20, left: 15),
      child: ExpansionTile(
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: AppColors.white,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  // controller: searchController,
                  style: TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                    hintStyle:
                        TextStyle(color: AppColors.white.withOpacity(0.5)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
          ],
        ),
        children: [],
      ),
    );
  }
}
