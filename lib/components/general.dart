import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';
import 'package:window_manager/window_manager.dart';

class WindowActions extends StatelessWidget {
  const WindowActions({
    super.key,
    required this.isDarkMode,
    required this.ref,
    required this.theme
  });

  final bool isDarkMode;
  final WidgetRef ref;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform.scale(
          scale: .7,
          child: Switch(
            value: isDarkMode,
            onChanged: ref.read(settingsServiceProvider.notifier).swithTheme,
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 138,
          height: 50,
          child: WindowCaption(
            brightness: theme.brightness,
            backgroundColor: Colors.transparent,
          ),
        )
      ],
    );
  }
}
