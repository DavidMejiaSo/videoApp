import 'package:dio/dio.dart';

import '../../enviroments/enviroments.dart';
import '../../infrastructure/entities/Video.dart';
import '../../infrastructure/mappers/video_mapper.dart';

class VideosService {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));

  Future<List<Video>> getAllVideos(String token) async {
    try {
      final response = await dio.get(
        '/video',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final List<Video> videos = VideoMapper.jsonToEntityList(response.data);
      return videos;
    } catch (e) {
      throw Exception("Algo salió mal: ${e.toString()}");
    }
  }
}
