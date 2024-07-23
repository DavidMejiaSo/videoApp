import 'dart:io';

class NewVideoPost {
  final DateTime date;

  final String description;
  final File video;

  NewVideoPost(
      {required this.date, required this.description, required this.video});
}
