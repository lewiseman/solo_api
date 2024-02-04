import 'package:solo_api/common.dart';

class SoloApiSettings {
  SoloApiSettings.initial() : isDarkMode = false;
  SoloApiSettings({required this.isDarkMode});
  final bool isDarkMode;
}

final settingsServiceProvider =
    StateNotifierProvider<SettingsNotifier, SoloApiSettings>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<SoloApiSettings> {
  SettingsNotifier() : super(SoloApiSettings.initial());

  void swithTheme(bool value) {
    state = SoloApiSettings(isDarkMode: value);
  }
}
