import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide Colors, IconButton, showDialog;
import 'package:solo_api/common.dart' hide ContentDialog;
import 'package:solo_api/modules/apis/views/body.dart';
import 'package:window_manager/window_manager.dart';

class RootApiFolder extends ConsumerStatefulWidget {
  final APIFolder folder;
  const RootApiFolder({super.key, required this.folder});

  @override
  ConsumerState<RootApiFolder> createState() => _RootApiFolderState();
}

class _RootApiFolderState extends ConsumerState<RootApiFolder> {
  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  APIRoute? currentRoute;
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final realm = ref.read(realmProvider);
    final routes = realm.query<APIRoute>('folder ==\$0', [widget.folder]);

    return StreamBuilder(
      stream: routes.changes,
      builder: (context, snapshot) {
        final routesData = snapshot.data?.results.toList() ?? [];
        final currentIndex = routesData.indexed
            .where((element) => element.$2 == currentRoute)
            .firstOrNull
            ?.$1;
        return NavigationView(
          appBar: NavigationAppBar(
            automaticallyImplyLeading: true,
            leading: PaneItem(
              icon: const Center(child: Icon(FluentIcons.back, size: 12.0)),
              body: const SizedBox.shrink(),
            ).build(context, false, () => Navigator.of(context).pop()),
            title: DragToMoveArea(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  widget.folder.name,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            actions: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: ToggleSwitch(
                    checked: FluentTheme.of(context).brightness.isDark,
                    onChanged: (bool value) {},
                  ),
                ),
                const SizedBox(
                  width: 138,
                  height: 50,
                  child: WindowCaption(
                    backgroundColor: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
          pane: NavigationPane(
            // selected: currentIndex == null ? null : currentIndex + 1,
            selected: 1,
            displayMode: PaneDisplayMode.open,
            // size: const NavigationPaneSize(openMaxWidth: 250),

            items: [
              PaneItem(
                key: const ValueKey('/popups/flyout'),
                icon: const Icon(FluentIcons.pop_expand),
                title: const Text('Flyout'),
                body: const SizedBox.shrink(),
              ),
              PaneItem(
                key: const ValueKey('/popups/flyout'),
                icon: const Icon(FluentIcons.pop_expand),
                title: const Text('Flyout'),
                body: const SizedBox.shrink(),
              ),
              // PaneItem(
              //   key: const ValueKey('/popups/flyout'),
              //   icon: const Icon(FluentIcons.pop_expand),
              //   title: const Text('Flyout'),
              //   body: const SizedBox.shrink(),
              // ),
              ...routesData.map((e) {
                return PaneItemAction(
                  key: ValueKey(e.id),
                  icon: const Icon(FluentIcons.home),
                  title: Text(e.name),
                  onTap: () {
                    setState(() {
                      currentRoute = e;
                    });
                  },
                );
              })
            ],
            // autoSuggestBox: Builder(
            //   builder: (context) {
            //     return AutoSuggestBox(
            //       focusNode: searchFocusNode,
            //       unfocusedColor: Colors.transparent,
            //       placeholder: 'Search',
            //       controller: searchController,
            //       trailingIcon: IgnorePointer(
            //         child: IconButton(
            //           onPressed: () {},
            //           icon: const Icon(FluentIcons.search),
            //         ),
            //       ),
            //       items: [
            //         ...routesData.map(
            //           (e) => AutoSuggestBoxItem(
            //             value: e.id,
            //             label: e.name,
            //             onSelected: () {
            //               searchController.clear();
            //               searchFocusNode.unfocus();
            //             },
            //           ),
            //         )
            //       ],
            //     );
            //   },
            // ),
            // autoSuggestBoxReplacement: const Icon(FluentIcons.search),
            footerItems: [
              PaneItemAction(
                icon: const Icon(FluentIcons.add),
                title: const Text('Add'),
                onTap: () {
                  TextFormBox();
                  final x = ContentDialog();
                },
              ),
            ],
          ),
          paneBodyBuilder: (item, body) {
            return FocusTraversalGroup(
              child: currentRoute != null
                  ? APIRouteBody(
                      route: currentRoute!,
                    )
                  : Text('No api'),
            );
          },
          onOpenSearch: searchFocusNode.requestFocus,
        );
      },
    );
  }
}
