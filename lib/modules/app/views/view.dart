import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';
import 'package:solo_api/modules/apis/views/root.dart';
import 'package:solo_api/modules/app/views/_widgets.dart';
import 'package:window_manager/window_manager.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key, required this.settings});
  final SoloApiSettings settings;

  @override
  ConsumerState<RootPage> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> {
  int? currentHoverBox;
  @override
  Widget build(BuildContext context) {
    final realm = ref.read(realmProvider);
    final folders = realm.all<APIFolder>();
    final theme = Theme.of(context);
    return Material(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DragToMoveArea(
            child: WindowActions(
              isDarkMode: widget.settings.isDarkMode,
              ref: ref,
              theme: theme,
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: folders.changes,
                builder: (context, snapshot) {
                  final foldersData = snapshot.data?.results.toList();
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: const CupertinoSearchTextField(),
                          ),
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: double.maxFinite,
                          child: Wrap(
                            runSpacing: 16,
                            spacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              ...foldersData?.indexed.map(
                                    (e) => HomeCardFrame(
                                      context: context,
                                      index: e.$1,
                                      theme: theme,
                                      currentHoverBox: currentHoverBox,
                                      onHover: (v) {
                                        setState(() {
                                          if (v) {
                                            currentHoverBox = e.$1;
                                          } else {
                                            currentHoverBox = null;
                                          }
                                        });
                                      },
                                      onDelete: () {
                                        realm.write(() {
                                          realm.delete(e.$2);
                                        });
                                      },
                                      onRename: () {
                                        updateApiFolder(
                                          context,
                                          realm,
                                          folder: e.$2,
                                        );
                                      },
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => RootApiFolder(
                                              folder: e.$2,
                                              settings: widget.settings,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        e.$2.name,
                                        style: const TextStyle(fontSize: 16),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ) ??
                                  [],
                              HomeCardFrame(
                                context: context,
                                index: -1,
                                theme: theme,
                                currentHoverBox: currentHoverBox,
                                onHover: (v) {
                                  setState(() {
                                    if (v) {
                                      currentHoverBox = -1;
                                    } else {
                                      currentHoverBox = null;
                                    }
                                  });
                                },
                                child: const Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.add_rounded),
                                      Text(
                                        'Add',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  updateApiFolder(context, realm);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
