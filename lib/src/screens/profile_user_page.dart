import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_app/src/providers/favourites_user_provider.dart';

import '../../design_tools/tool_widgets/app_colors.dart';
import '../../enviroments/enviroments.dart';
import '../../widgets/video_card.dart';
import '../../widgets/video_thumbnail.dart';
import '../providers/authentication_provider.dart';

import '../providers/user_video_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;
    final videos = ref.watch(userVideoProvider).videos;
    final favourites = ref.watch(favouriteProvider).favourites;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.lock, color: Colors.black, size: 18),
            Text(user?.name ?? '', style: TextStyle(color: Colors.black)),
            const Icon(Icons.more_vert, color: Colors.black),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.white,
              child: Column(
                children: [
                  profilePhoto(user!.photoUrl, user.name),
                  const SizedBox(height: 10),
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatColumn("10", "Posts"),
                      const SizedBox(width: 20),
                      _buildStatColumn(
                          favourites.length.toString(), "Likes you"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.home_filled, color: Colors.black),
                        onPressed: () async {
                          GoRouter.of(context).go('/landingPage');
                        },
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline,
                            color: Colors.black),
                        onPressed: () {
                          GoRouter.of(context).go('/newPostPage');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.white,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: VideoPostWidget(video: video),
                            );
                          },
                        );
                      },
                      child: VideoThumbnail(video: video),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profilePhoto(String imageUrl, String name) {
    String url = Enviroment.Url;
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage('$url$imageUrl'),
    );
  }

  Widget _buildStatColumn(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.facebook,
            color: Colors.blue,
          ),
          onPressed: () {
            // Acción cuando se presiona el ícono de Facebook
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.bluetooth,
            color: AppColors.white,
          ),
          onPressed: () {
            // Acción cuando se presiona el ícono de Instagram
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.message,
            color: AppColors.white,
          ),
          onPressed: () {
            // Acción cuando se presiona el ícono de mensajería
          },
        ),
      ],
    );
  }
}
