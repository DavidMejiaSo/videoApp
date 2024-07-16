import 'package:riverpod/riverpod.dart';
import 'package:video_app/datasource/API/video_service.dart';

import '../../error/errors.dart';

import '../../infrastructure/entities/Video.dart';

import '../../storage/key_value_storage_service _implementation.dart';
import '../../storage/key_value_storage_service.dart';

final videoProvider = StateNotifierProvider<VideoNotifier, VideoState>((ref) {
  final videoRepository = VideosService();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return VideoNotifier(
    videoRepository: videoRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class VideoNotifier extends StateNotifier<VideoState> {
  final VideosService videoRepository;
  final KeyValueStorageService keyValueStorageService;
  VideoNotifier(
      {required this.videoRepository, required this.keyValueStorageService})
      : super(VideoState()) {
    getAllVideos();
  }

  void getAllVideos() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token != null) {
      try {
        final videos = await videoRepository.getAllVideos(token);
        _setListVideo(videos);
        //print("vv");
        print(videos);
      } on CustomError catch (e) {
        error(errorMessage: e.message);
      } catch (e) {
        error(errorMessage: 'Error desconocido ${e.toString()}');
      }
    }
  }

  void _setListVideo(List<Video> videos) async {
    // await keyValueStorageService.setKeyValue('token', user.token);

    // await keyValueStorageService.setKeyValue('token', user.token);
    //TODO: Necesito guardar el token en storage
    state = state.copyWith(videos: videos);
  }

  error({String? errorMessage}) async {
    //await keyValueStorageService.removeKey('token');
    //todo: lIMPIAR TOKEN
    state = state.copyWith(errorMessage: 'Error al cargar');
  }
}

class VideoState {
  final List<Video>? videos;
  final String errorMessage;

  VideoState({
    this.videos = const [],
    this.errorMessage = '',
  });

  VideoState copyWith({
    List<Video>? videos,
    String? errorMessage,
  }) =>
      VideoState(
        videos: videos ?? this.videos,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
