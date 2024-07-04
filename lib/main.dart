import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_app/routes/routes.dart';

void main() async {
  // await Environment.initEnvironment();
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
