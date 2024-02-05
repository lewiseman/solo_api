import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';
import 'package:solo_api/components/action_tile.dart';
import 'package:solo_api/modules/apis/views/body.dart';
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
            child: APINeck(
              theme: theme,
              folder: folder,
            ),
          )
        ],
      ),
    );
  }
}

class APINeck extends ConsumerStatefulWidget {
  const APINeck({
    super.key,
    required this.theme,
    required this.folder,
  });

  final ThemeData theme;
  final APIFolder folder;

  @override
  ConsumerState<APINeck> createState() => _APINeckState();
}

class _APINeckState extends ConsumerState<APINeck> {
  int? selectedIndex;
  APIRoute? route;
  late Realm realm;
  @override
  void initState() {
    super.initState();
    realm = ref.read(realmProvider);
  }

  @override
  Widget build(BuildContext context) {
    final routes = realm.query<APIRoute>('folder ==\$0', [widget.folder]);
    return Split(
      axis: Axis.horizontal,
      initialFractions: const [.2, .8],
      children: [
        Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: routes.changes,
                builder: (context, snapshot) {
                  final data = snapshot.data?.results;
                  return ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      final navroute = data?[index];
                      return ActionTile(
                        title: navroute?.name ?? '',
                        selected: selectedIndex == index,
                        icon: Icons.add_rounded,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            route = navroute;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: -15,
                    left: 0,
                    child: Divider(
                      height: 1,
                      color: widget.theme.dividerColor,
                    ),
                  )
                ],
              ),
            ),
            ActionTile(
              title: 'Add',
              icon: Icons.add_rounded,
              onTap: () {},
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: widget.theme.canvasColor,
            border: Border(
              left: BorderSide(color: widget.theme.dividerColor),
              top: BorderSide(color: widget.theme.dividerColor),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
            ),
          ),
          child: (route != null)
              ? APIRouteBody(
                  route: route!,
                  theme: widget.theme,
                )
              : const Center(
                  child: Text('Select an api'),
                ),
        ),
      ],
    );
  }
}
