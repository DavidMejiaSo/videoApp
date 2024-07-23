import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_app/infrastructure/entities/new_post.dart';
import 'package:video_player/video_player.dart';

import '../../design_tools/tool_widgets/app_buttons.dart';
import '../../design_tools/tool_widgets/app_colors.dart';
import '../../design_tools/tool_widgets/spacing.dart';
import '../../design_tools/tool_widgets/tool_widgets.dart';
import '../providers/user_video_provider.dart';

class CreateVideoScreen extends ConsumerStatefulWidget {
  const CreateVideoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateVideoScreenState();
}

class _CreateVideoScreenState extends ConsumerState<CreateVideoScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  File? _video;
  String description = "";
  VideoPlayerController? _videoPlayerController;

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      final videoFile = File(pickedFile.path);
      _videoPlayerController = VideoPlayerController.file(videoFile)
        ..initialize().then((_) {
          setState(() {
            if (_videoPlayerController!.value.duration <=
                const Duration(minutes: 1)) {
              _video = videoFile;
              _videoPlayerController!.play();
            } else {
              // Mostrar un mensaje si el video es mayor a 1 minuto
              _videoPlayerController!.dispose();
              _videoPlayerController = null;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('El video no puede durar más de 1 minuto.')),
              );
            }
          });
        });
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sendPost = ref.watch(userVideoProvider.notifier);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                color: AppColors.white,
                child: Column(
                  children: [
                    //------------------------Bienvenido mensaje
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 16),
                          child: AppButtons().whiteButton(
                            icon: Icons.arrow_back,
                            context: context,
                            onPressed: () {
                              GoRouter.of(context).go('/profilePage');
                            },
                            fontSize: 5,
                            horizontalPadding: 4,
                            verticalPadding: 1,
                          ),
                        ),
                      ],
                    ),
                    // Contenido de la página
                    //----------------------------Zona del logo
                    AppWidgets.mainLogo(context, 75, 30),
                    //-------------------------------------

                    Row(
                      children: [
                        AppWidgets.mainText(context, "New Video", 6),
                      ],
                    ),
                    //--------------------------------------------
                    Spacing.vertical(2),

                    Row(
                      children: [
                        AppWidgets.smallText(context, "Upload your video", 4),
                      ],
                    ),
                    //-------------------------------------------
                    Spacing.vertical(10),

                    Row(
                      children: [
                        AppWidgets.mainText(context, "Description", 4),
                      ],
                    ),
                    //-------------------------------------------
                    Spacing.vertical(10),
                    Container(
                      // Container de la Descripción
                      color: const Color.fromARGB(255, 235, 235, 235),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Center(
                        child: TextFormField(
                          onChanged: (value) {
                            description = value;
                          },
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            labelText: "Description",
                            labelStyle: const TextStyle(),
                          ),
                        ),
                      ),
                    ),
                    //---------------------------------------
                    Spacing.vertical(10),

                    Row(
                      children: [
                        AppWidgets.mainText(context, "Video", 4),
                      ],
                    ),
                    Spacing.vertical(10),
                    GestureDetector(
                      onTap: _pickVideo,
                      child: Container(
                        color: const Color.fromARGB(255, 235, 235, 235),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height:
                            200, // Ajustar la altura para mostrar el thumbnail del video
                        child: Center(
                          child: _video == null
                              ? const Text("Tap to select a video")
                              : _videoPlayerController!.value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio: _videoPlayerController!
                                          .value.aspectRatio,
                                      child:
                                          VideoPlayer(_videoPlayerController!),
                                    )
                                  : const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    //----------------------------------------------
                    Spacing.vertical(10),
                    AppButtons().blackButton(
                      context: context,
                      texto: "Upload Video",
                      onPressed: () async {
                        final newPost = NewVideoPost(
                            date: DateTime.now(),
                            description: description,
                            video: _video!);

                        sendPost.postNewVideo(newPost);
                        // Aquí puedes implementar la lógica para subir el video
                      },
                      primaryColor: AppColors.red.withOpacity(0.6),
                      textColor: AppColors.white,
                      fontSize: 4,
                      horizontalPadding: 34,
                      verticalPadding: 1,
                    ),
                    Spacing.vertical(10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
