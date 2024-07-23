import 'package:dio/dio.dart';

import '../../enviroments/enviroments.dart';
import '../../infrastructure/entities/user.dart';
import '../../infrastructure/mappers/user_mapper.dart';

class Authentication {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));

  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get('/user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final user = UserMapper.simpleUserJsonToEntity(response.data);
      return user;
    } catch (e) {
      throw Exception(
          "Algo salió mal ${e.toString()}"); // Devuelve null en caso de error
    }
  }

  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post('/login', data: {'email': email, 'password': password});

      final user = UserMapper.simpleUserJsonToEntity(response.data);

      return user;
    } catch (e) {
      throw Exception("Algo salió mal ${e.toString()}");
    }
  }

  Future<User> register(NewUser newUser) async {
    try {
      // Crear FormData para enviar el archivo y los datos adicionales
      final formData = FormData.fromMap({
        'name': newUser.name,
        'email': newUser.email,
        'password': newUser.password,
        'photo_url': await MultipartFile.fromFile(newUser.profilePhoto.path,
            filename: 'profile_photo.jpg'),
      });

      final response = await dio.post(
        '/register',
        data: formData,
      );

      print(response.data);
      final user = UserMapper.simpleUserJsonToEntity(response.data);

      return user;
    } catch (e) {
      throw Exception("Algo salió mal ${e.toString()}");
    }
  }
}
