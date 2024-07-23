import 'dart:io';

class Video {
  // Esta es la entidad para los conciertos
  final String id;
  final String videoLink;
  final String date;
  final int like;
  final String ownerId;
  final String ownerName;
  final String description;

  Video({
    required this.id,
    required this.videoLink,
    required this.date,
    required this.like,
    required this.ownerId,
    required this.ownerName,
    required this.description,
  });
}
