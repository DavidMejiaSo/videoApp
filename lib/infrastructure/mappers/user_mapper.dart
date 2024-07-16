import '../entities/user.dart';

class UserMapper {
  static User simpleUserJsonToEntity(Map<String, dynamic> json) => User(
        id: json['id'] ?? 0.toString(),
        token: json['token'] ?? '',
        name: json['username'] ?? '',
        photoUrl: json['photo_url'],
        email: json['email'] ?? '',
      );
}
