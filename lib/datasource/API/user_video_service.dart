import 'package:dio/dio.dart';

import '../../enviroments/enviroments.dart';
import '../../infrastructure/entities/Video.dart';
import '../../infrastructure/entities/new_post.dart';
import '../../infrastructure/mappers/video_mapper.dart';

class UserVideosUser {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));

  Future<List<Video>> getAllUserVideos(String token) async {
    try {
      final response = await dio.get(
        '/user-videos',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final List<Video> videos = VideoMapper.jsonToEntityList(response.data);
      return videos;
    } catch (e) {
      throw Exception("Algo salió mal: ${e.toString()}");
    }
  }

  //_-----------------user new post -----------------

  Future<Video> postUserVideos(String token, NewVideoPost newVideo) async {
    try {
      // Asegúrate de inicializar Dio

      // Usa FormData para enviar el archivo
      final formData = FormData.fromMap({
        'date': newVideo.date.toIso8601String(), // Convierte DateTime a String
        'description': newVideo.description,
        'videoLink': await MultipartFile.fromFile(
          newVideo.video.path,
          filename:
              'video.mp4', // Asegúrate de usar un nombre de archivo apropiado
        ), // Usa MultipartFile para el archivo
      });

      final response =
          await dio.post('/video', // Asegúrate de que la URL sea correcta
              data: formData,
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ));

      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      final Video video = VideoMapper.jsonToEntity(response.data['video']);
      return video;
    } catch (e) {
      print('Error: ${e.toString()}');
      throw Exception("Algo salió mal: ${e.toString()}");
    }
  }
  // Future<Video> createNewVideo(String token, NewVideoPost newvideo) async {
  //   try {
  //     final response = await dio.post(
  //       '/video',
  //       data: {
  //         'date': newvideo.date,
  //         'description': newvideo.description,
  //         'videoLink': newvideo.video,
  //       },
  //       options: Options(headers: {'Authorization': 'Bearer $token'}),
  //     );
  //     print(response);
  //     final Video video = VideoMapper.jsonToEntity(response.data);
  //     return video;
  //   } catch (e) {
  //     throw Exception("Algo salió mal: ${e.toString()}");
  //   }
  // }
}
