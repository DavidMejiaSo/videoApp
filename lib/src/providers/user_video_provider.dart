import 'package:riverpod/riverpod.dart';
import 'package:video_app/datasource/API/user_video_service.dart';
import 'package:video_app/infrastructure/entities/new_post.dart';

import '../../error/errors.dart';

import '../../infrastructure/entities/Video.dart';

import '../../storage/key_value_storage_service _implementation.dart';
import '../../storage/key_value_storage_service.dart';

final userVideoProvider =
    StateNotifierProvider<UserVideoNotifier, UserVideosState>((ref) {
  final videoRepository = UserVideosUser();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return UserVideoNotifier(
    videoRepository: videoRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class UserVideoNotifier extends StateNotifier<UserVideosState> {
  final UserVideosUser videoRepository;
  final KeyValueStorageService keyValueStorageService;
  UserVideoNotifier(
      {required this.videoRepository, required this.keyValueStorageService})
      : super(UserVideosState()) {
    getAllUserVideos();
  }

  void getAllUserVideos() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token != null) {
      try {
        final videos = await videoRepository.getAllUserVideos(token);
        _setListVideo(videos);
        //print("vv");
      } on CustomError catch (e) {
        error(informationMessage: e.message);
      } catch (e) {
        error(informationMessage: 'Error desconocido ${e.toString()}');
      }
    }
  }

  void postNewVideo(NewVideoPost videoPost) async {
    final token = await keyValueStorageService.getValue<String>('token');
    if (token != null) {
      try {
        final video = await videoRepository.postUserVideos(token, videoPost);

        //print("vv");

        _setNewVideoPost(video);
      } on CustomError catch (e) {
        error(informationMessage: e.message);
      } catch (e) {
        error(informationMessage: 'Error desconocido ${e.toString()}');
      }
    }
  }

  void _setListVideo(List<Video> videos) async {
    // await keyValueStorageService.setKeyValue('token', user.token);

    // await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(videos: videos);
  }

  void _setNewVideoPost(Video video) async {
    // Crear una nueva lista que incluya el nuevo video
    final updatedVideos = List<Video>.from(state.videos)..add(video);

    // Actualizar el estado con la nueva lista de videos y el mensaje de información
    state = state.copyWith(
      videos: updatedVideos,
      videoNewPost: video,
      informationMessage: "Post Success!",
    );
    // await keyValueStorageService.setKeyValue('token', user.token);

    // await keyValueStorageService.setKeyValue('token', user.token);
  }

  error({String? informationMessage}) async {
    //await keyValueStorageService.removeKey('token');
    //todo: lIMPIAR TOKEN
    state = state.copyWith(informationMessage: 'Error al cargar');
  }
}

class UserVideosState {
  final List<Video> videos;
  final Video? videoNewPost;
  final String informationMessage;

  UserVideosState({
    this.videos = const [],
    this.informationMessage = '',
    this.videoNewPost,
  });

  UserVideosState copyWith({
    List<Video>? videos,
    Video? videoNewPost,
    String? informationMessage,
  }) =>
      UserVideosState(
        videos: videos ?? this.videos,
        videoNewPost: videoNewPost ?? this.videoNewPost,
        informationMessage: informationMessage ?? this.informationMessage,
      );
}
