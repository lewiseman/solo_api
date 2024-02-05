import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(
      TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    await windowManager.setMinimumSize(const Size(500, 600));
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });
  runApp(
    const ProviderScope(child: SoloApi()),
  );
}

class SoloApi extends ConsumerWidget {
  const SoloApi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsServiceProvider);
    return MaterialApp(
      title: 'SoloApi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: RootPage(settings: settings),
    );
  }
}
