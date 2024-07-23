import '../../enviroments/enviroments.dart';
import '../entities/Video.dart';

class VideoMapper {
  static List<Video> jsonToEntityList(List<dynamic>? json) {
    final url = Enviroment.Url;
    final List<Video> videos = [];

    if (json != null) {
      for (final item in json) {
        final id = item['_id'].toString();
        final videoLink = item['videoLink'] ?? '';
        final date = DateTime.parse(item['date']).toLocal().toString();
        final like = item['like'] ?? 0;
        final ownerId = item['ownerId'] ?? '';
        final ownerName = item['ownerName'] ?? '';

        final description = item['description'] ?? '';

        final video = Video(
          id: id,
          videoLink: '$url$videoLink',
          date: date,
          like: like,
          ownerId: ownerId,
          ownerName: ownerName,
          description: description,
        );

        videos.add(video);
      }
    }

    return videos;
  }

  static Video jsonToEntity(Map<String, dynamic> json) {
    final url = Enviroment.Url;

    final id = json['_id'].toString();
    final videoLink = json['videoLink'] ?? '';
    final date = DateTime.parse(json['date']).toLocal().toString();
    final like = json['like'] ?? 0;
    final ownerId = json['ownerId'] ?? '';
    final ownerName = json['ownerName'] ?? '';

    final description = json['description'] ?? '';

    return Video(
      id: id,
      videoLink: '$url$videoLink',
      date: date,
      like: like,
      ownerId: ownerId,
      ownerName: ownerName,
      description: description,
    );
  }
}
