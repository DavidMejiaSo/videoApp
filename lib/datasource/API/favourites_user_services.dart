import 'package:dio/dio.dart';

import '../../enviroments/enviroments.dart';

class FavouritesService {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));

  Future<List<String>> getFavourites(String token) async {
    try {
      final response = await dio.post(
        '/favourites',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print(response.data['favourite']['favourites']);
      final List<String> favourites =
          List<String>.from(response.data['favourite']['favourites']);
      return favourites;
    } catch (e) {
      throw Exception("Algo salió mal ${e.toString()}"); // Devuw
    }
  }

  Future<String> updateFavourites(String token, List<String> favourites) async {
    try {
      final response = await dio.put(
        '/favourites',
        data: {'favourites': favourites},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final message = response.data['message'];
      return message.toString();
    } catch (e) {
      throw Exception("Algo salió mal: ${e.toString()}");
    }
  }

//In the backend it is configured along with the video routes but this is to manage the count of likes or dislikes

  Future<String> addLike(String token, String postId) async {
    try {
      final response = await dio.post('/video/$postId/like',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final message = response.data.toString();

      return message;
    } catch (e) {
      throw Exception("Algo salió mal ${e.toString()}");
    }
  }

  Future<String> removeLike(String token, String postId) async {
    try {
      final response = await dio.post('/video/$postId/unlike',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final message = response.data.toString();

      return message;
    } catch (e) {
      throw Exception("Algo salió mal ${e.toString()}");
    }
  }
}
