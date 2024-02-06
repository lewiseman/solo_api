import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:solo_api/common.dart';
import 'package:solo_api/modules/apis/services/request_srv.dart';

class APIRequestHead extends ConsumerStatefulWidget {
  final APIRoute route;
  final ThemeData theme;
  final AsyncValue? routeData;
  final VoidCallback onDelete;
  const APIRequestHead({
    super.key,
    required this.route,
    required this.theme,
    required this.routeData,
    required this.onDelete,
  });

  @override
  ConsumerState<APIRequestHead> createState() => _APIRequestHeadState();
}

class _APIRequestHeadState extends ConsumerState<APIRequestHead> {
  @override
  void didUpdateWidget(covariant APIRequestHead oldWidget) {
    if (oldWidget.route != widget.route) {
      final myroute = widget.route;
      urlController.text = myroute.url ?? '';
      nameController.text = myroute.name;
    }

    super.didUpdateWidget(oldWidget);
  }

  late final urlController = TextEditingController(text: widget.route.url);
  late final nameController = TextEditingController(text: widget.route.name);
  bool editingName = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TapRegion(
                  onTapOutside: (event) {
                    if (editingName) {
                      setState(() {
                        editingName = false;
                      });
                    }
                  },
                  child: editingName
                      ? TextField(
                          controller: nameController,
                          autofocus: true,
                          onChanged: (value) {
                            final realm = ref.read(realmProvider);
                            realm.write(() {
                              widget.route.name = value;
                            });
                          },
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Enter the API name',
                          ),
                        )
                      : MouseRegion(
                          cursor: SystemMouseCursors.text,
                          child: GestureDetector(
                            onDoubleTap: () {
                              setState(() {
                                editingName = true;
                              });
                            },
                            child: Text(
                              widget.route.name.isEmpty
                                  ? 'Enter the API name'
                                  : widget.route.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              PullDownButton(
                itemBuilder: (BuildContext context) {
                  return [
                    PullDownMenuActionsRow.medium(
                      items: [
                        PullDownMenuItem(
                          onTap: () {
                            final realm = ref.read(realmProvider);
                            realm.write(() => realm.delete(widget.route));
                            widget.onDelete();
                          },
                          title: 'Delete',
                          icon: CupertinoIcons.delete,
                          isDestructive: true,
                        ),
                      ],
                    ),
                  ];
                },
                buttonBuilder: (context, showMenu) => IconButton(
                  onPressed: showMenu,
                  hoverColor: Theme.of(context).scaffoldBackgroundColor,
                  style: IconButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.more_vert_rounded,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: widget.theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.theme.dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: widget.theme.dividerColor,
                              ),
                            ),
                          ),
                          child: PullDownButton(
                            itemBuilder: (BuildContext context) {
                              return RequestType.values
                                  .map((e) => PullDownMenuItem.selectable(
                                        onTap: () {
                                          final realm = ref.read(realmProvider);
                                          realm.write(() {
                                            widget.route.method = e.toString();
                                          });
                                        },
                                        title: e.toString(),
                                        icon: CupertinoIcons.delete,
                                        selected:
                                            e.toString() == widget.route.method,
                                      ))
                                  .toList();
                            },
                            buttonBuilder: (context, showMenu) => InkWell(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(6),
                              ),
                              onTap: showMenu,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Text(widget.route.method),
                                    const Icon(
                                        Icons.keyboard_arrow_down_rounded)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: urlController,
                              onChanged: (value) {
                                final realm = ref.read(realmProvider);
                                realm.write(() {
                                  widget.route.url = value;
                                });
                              },
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Enter URL',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              FilledButton(
                onPressed: widget.routeData.runtimeType == AsyncLoading
                    ? null
                    : () {
                        if (nameController.text.isNotEmpty) {
                          ref
                              .read(apiRequestServiceProvider.notifier)
                              .sendRequest(widget.route);
                        }
                      },
                child: widget.routeData.runtimeType == AsyncLoading
                    ? const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Send'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
