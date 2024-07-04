import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

import 'package:video_app/src/screens/login_page.dart';
import 'package:video_app/src/screens/register_page.dart';

import '../src/screens/landing_page.dart';

final goRouterProvider = StateProvider((ref) {
  //final user = ref.watch(authProvider);
  //final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    redirectLimit: 3,
    initialLocation: '/loginPage',
    //refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        name: 'login_page',
        path: '/loginPage',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'register_page',
        path: '/registerPage',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: 'landing_page',
        path: '/landingPage',
        builder: (context, state) => const LandingScreen(),
      ),
    ],

    // redirect: (context, state) {
    //   // final authStatus = user.authStatus;
//
    //   //  if (authStatus == AuthStatus.notAuthenticated) {
    //   //    if (state.fullPath == "/loginPage") return null;
    //   //    return '/loginPage';
    //   //  }
//
    //   //  if (authStatus == AuthStatus.authenticated) {
    //   //    if (state.fullPath == '/loginPage') {
    //   //      return '/landingPage';
    //   //    }
    //   //  }
    //   //  return null;
    // },
  );
});
