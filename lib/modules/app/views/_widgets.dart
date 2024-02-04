import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

class HomeCardFrame extends StatelessWidget {
  const HomeCardFrame({
    super.key,
    required this.child,
    required BuildContext context,
    required this.onTap,
    required this.index,
    required this.theme,
    required this.onHover,
    this.currentHoverBox,
    this.onDelete,
    this.onRename,
  });

  final Widget child;
  final VoidCallback onTap;
  final int index;
  final ThemeData theme;
  final ValueChanged<bool> onHover;
  final int? currentHoverBox;
  final VoidCallback? onDelete;
  final VoidCallback? onRename;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: theme.canvasColor,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        onHover: onHover,
        child: Container(
          width: 200,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: theme.dividerColor, width: .7),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(padding: const EdgeInsets.all(10), child: child),
              ),
              if (index != -1)
                PullDownButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      PullDownMenuActionsRow.medium(
                        items: [
                          PullDownMenuItem(
                            onTap: onRename,
                            title: 'Rename',
                            icon: CupertinoIcons.pencil,
                          ),
                          PullDownMenuItem(
                            onTap: onDelete,
                            title: 'Delete',
                            icon: CupertinoIcons.delete,
                            isDestructive: true,
                          ),
                        ],
                      ),
                    ];
                  },
                  buttonBuilder: (context, showMenu) => AnimatedOpacity(
                    opacity: currentHoverBox == index ? 1 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: IconButton(
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget frame({
  required Widget child,
  required BuildContext context,
  required VoidCallback onTap,
  Widget? action,
  required int index,
  required ThemeData theme,
  required ValueChanged<bool> onHover,
  int? currentHoverBox,
}) {
  return Material(
    color: theme.canvasColor,
    borderRadius: BorderRadius.circular(4),
    child: InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: onTap,
      onHover: onHover,
      child: Container(
        width: 200,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: theme.dividerColor, width: .7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(padding: const EdgeInsets.all(10), child: child),
            ),
            if (index != -1)
              AnimatedOpacity(
                opacity: currentHoverBox == index ? 1 : 0,
                duration: const Duration(milliseconds: 250),
                child: IconButton(
                  onPressed: () {},
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
              )
          ],
        ),
      ),
    ),
  );
}
