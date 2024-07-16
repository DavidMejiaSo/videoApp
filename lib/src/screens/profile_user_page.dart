import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../design_tools/tool_widgets/app_colors.dart';

import '../../enviroments/enviroments.dart';
import '../providers/authentication_provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.lock, color: Colors.black, size: 18),
            // ignore: prefer_const_constructors
            Text(user?.name ?? '', style: TextStyle(color: Colors.black)),
            const Icon(Icons.more_vert, color: Colors.black),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    const Text(
                      "Bajista",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStatColumn("10", "Posts"),
                        const SizedBox(width: 20),
                        _buildStatColumn("180", "Following"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).go('/landingPage');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(
                            color: Color.fromARGB(255, 72, 23, 23)),
                      ),
                      child: const Text("Edit Profile"),
                    ),
                    SizedBox(height: 20),
                    _buildSocialMediaIcons(),
                  ],
                ),
              ),
              Container(
                color: AppColors.white,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 1,
                  ),
                  itemCount: 12, // Número de publicaciones
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: Text(
                          "Post $index",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
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
