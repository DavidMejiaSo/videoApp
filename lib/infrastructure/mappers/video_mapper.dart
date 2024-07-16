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
}
