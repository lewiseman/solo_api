import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';
import 'package:window_manager/window_manager.dart';

class RootApiFolder extends ConsumerWidget {
  final APIFolder folder;
  final SoloApiSettings settings;
  const RootApiFolder({
    super.key,
    required this.folder,
    required this.settings,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Material(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          DragToMoveArea(
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          folder.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                WindowActions(
                  isDarkMode: settings.isDarkMode,
                  ref: ref,
                  theme: theme,
                ),
              ],
            ),
          ),
          Expanded(
            child: APINeck(theme: theme),
          )
        ],
      ),
    );
  }
}

class APINeck extends StatelessWidget {
  const APINeck({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Split(
      axis: Axis.horizontal,
      initialFractions: [.3, .7],
      children: [
        const Text("asdsd"),
        Container(
          decoration: BoxDecoration(
            color: theme.canvasColor,
            border: Border(
              left: BorderSide(color: theme.dividerColor),
              top: BorderSide(color: theme.dividerColor),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
            ),
          ),
          child: const Text('body'),
        ),
      ],
    );
  }
}
