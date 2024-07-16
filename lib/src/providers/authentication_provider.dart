import 'package:riverpod/riverpod.dart';

import '../../datasource/API/authentication.dart';

import '../../error/errors.dart';

import '../../infrastructure/entities/user.dart';
import '../../storage/key_value_storage_service _implementation.dart';
import '../../storage/key_value_storage_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = Authentication();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Authentication authRepository;
  final KeyValueStorageService keyValueStorageService;
  AuthNotifier(
      {required this.authRepository, required this.keyValueStorageService})
      : super(AuthState()) {
    checkStatus();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      _settLoggedUser(user);
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } catch (e) {
      logout(errorMessage: 'Error desconocido ${e.toString()}');
    }
  }

  logout({String? errorMessage}) async {
    await keyValueStorageService.removeKey('token');
    //todo: lIMPIAR TOKEN
    state = state.copyWith(
        token: null,
        user: null,
        userId: null,
        authStatus: AuthStatus.notAuthenticated,
        errorMessage: 'Sesión finalizada');
  }

  void checkStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token != null) {
      try {
        final user = await authRepository.checkAuthStatus(token);
        _settLoggedUser(user);
        print("vv");
        print(user.token);
      } on CustomError catch (e) {
        logout(errorMessage: e.message);
      } catch (e) {
        logout(errorMessage: 'Error desconocido ${e.toString()}');
      }
    }
  }

  void _settLoggedUser(User user) async {
    await keyValueStorageService.setKeyValue('token', user.token);

    // await keyValueStorageService.setKeyValue('token', user.token);
    //TODO: Necesito guardar el token en storage
    state = state.copyWith(
        token: user.token,
        userId: user.id,
        user: user,
        authStatus: AuthStatus.authenticated,
        errorMessage: 'Bienvenido ${user.name}');
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String? token;
  final String? userId;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.token,
      this.userId,
      this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? token,
    String? userId,
    String? errorMessage,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          userId: userId ?? this.userId,
          errorMessage: errorMessage ?? this.errorMessage,
          token: token ?? this.token);
}
