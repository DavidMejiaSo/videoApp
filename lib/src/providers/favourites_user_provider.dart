import 'package:riverpod/riverpod.dart';
import 'package:video_app/datasource/API/favourites_user_services.dart';

import '../../error/errors.dart';
import '../../storage/key_value_storage_service _implementation.dart';
import '../../storage/key_value_storage_service.dart';

final favouriteProvider =
    StateNotifierProvider<FavouritesNotifier, FavouriteState>((ref) {
  final favouriteRepository = FavouritesService();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return FavouritesNotifier(
    favouriteRepository: favouriteRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class FavouritesNotifier extends StateNotifier<FavouriteState> {
  final FavouritesService favouriteRepository;
  final KeyValueStorageService keyValueStorageService;
  FavouritesNotifier(
      {required this.favouriteRepository, required this.keyValueStorageService})
      : super(FavouriteState()) {
    getAllfavourites();
  }

  void getAllfavourites() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token != null) {
      try {
        final favourites = await favouriteRepository.getFavourites(token);
        _setListVideo(favourites);
        //print("vv");
      } on CustomError catch (e) {
        error(informationMessage: e.message);
      } catch (e) {
        error(informationMessage: 'Error desconocido ${e.toString()}');
      }
    }
  }

  void _setListVideo(List<String> favourites) async {
    // await keyValueStorageService.setKeyValue('token', user.token);

    // await keyValueStorageService.setKeyValue('token', user.token);
    //TODO: Necesito guardar el token en storage
    state = state.copyWith(favourites: favourites);
  }

  void addlike(String postId) async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token != null) {
      try {
        final like_message = await favouriteRepository.addLike(token, postId);
        final updatedVideos = List<String>.from(state.favourites)..add(postId);

        // Actualizar el estado con la nueva lista de videos y el mensaje de información
        state = state.copyWith(
          favourites: updatedVideos,
          informationMessage: like_message,
        );

        updateDataOnServer(token, updatedVideos);

        //print("vv");
        //print(favourites);
      } on CustomError catch (e) {
        error(informationMessage: e.message);
      } catch (e) {
        error(informationMessage: 'Error desconocido ${e.toString()}');
      }
    }
  }

  void updateDataOnServer(String token, List<String> favourites) async {
    await favouriteRepository.updateFavourites(token, favourites);
  }

  void unlike(String postId) async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token != null) {
      try {
        final unlike_message =
            await favouriteRepository.removeLike(token, postId);
        final updatedVideos = List<String>.from(state.favourites)
          ..remove(postId);

        // Actualizar el estado con la nueva lista de videos y el mensaje de información
        state = state.copyWith(
          favourites: updatedVideos,
          informationMessage: unlike_message,
        );
        updateDataOnServer(token, updatedVideos);

        //print("vv");
        //print(favourites);
      } on CustomError catch (e) {
        error(informationMessage: e.message);
      } catch (e) {
        error(informationMessage: 'Error desconocido ${e.toString()}');
      }
    }
  }

  error({String? informationMessage}) async {
    //await keyValueStorageService.removeKey('token');
    //todo: lIMPIAR TOKEN
    state = state.copyWith(informationMessage: 'Error al cargar');
  }
}

class FavouriteState {
  final List<String> favourites;
  final String informationMessage;

  FavouriteState({
    this.favourites = const [],
    this.informationMessage = '',
  });

  FavouriteState copyWith({
    List<String>? favourites,
    String? informationMessage,
  }) =>
      FavouriteState(
        favourites: favourites ?? this.favourites,
        informationMessage: informationMessage ?? this.informationMessage,
      );
}
