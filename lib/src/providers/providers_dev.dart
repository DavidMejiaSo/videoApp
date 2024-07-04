import 'package:riverpod/riverpod.dart';

import '../../infrastructure/entities/video.dart';

final videosListProvider = StateProvider<List<Video>>((ref) {
  return [
    Video(
      id: '1',
      videoLink:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      date: '2024-06-30',
      like: 100,
      ownerId: '1',
      ownerName: 'Ryner Escobar',
      description: 'Video de la primera sesión de sonido',
    ),
    Video(
      id: '2',
      videoLink:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      date: '2024-06-28',
      like: 150,
      ownerId: '2',
      ownerName: 'Daniel Montes',
      description: 'Video de la sesión de fotografía en exteriores',
    ),
    Video(
      id: '3',
      videoLink:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      date: '2024-06-25',
      like: 200,
      ownerId: '3',
      ownerName: 'Alex Calavera',
      description: 'Video de la segunda sesión de sonido',
    ),
    Video(
      id: '4',
      videoLink:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      date: '2024-06-20',
      like: 250,
      ownerId: '4',
      ownerName: 'Johan',
      description: 'Video de la sesión de fotografía en estudio',
    ),
  ];
});
