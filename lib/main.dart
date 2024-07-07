import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komikoo/router/app_router.dart';
import 'package:komikoo/theme/app_theme.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Komikoo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(false),
      darkTheme: AppTheme.getTheme(true),
      themeMode: ThemeMode.dark,
      builder: BotToastInit(),
      routerConfig: _appRouter.config(
        navigatorObservers: () => [BotToastNavigatorObserver()],
      ),
    );
  }
}
