import 'dart:io';

class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.token,
  });
}

class NewUser {
  // TODO: Create a new user
  final String name;
  final String email;
  final String password;
  final File profilePhoto;

  NewUser(
      {required this.name,
      required this.email,
      required this.password,
      required this.profilePhoto});
}
