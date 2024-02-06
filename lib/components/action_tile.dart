import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  const ActionTile({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.selected,
    this.trailing,
  });
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool? selected;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: ListTile(
        minLeadingWidth: 1,
        minVerticalPadding: 1,
        horizontalTitleGap: 8,
        trailing: trailing,
        contentPadding: const EdgeInsets.only(left: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        dense: true,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap,
        leading: (selected ?? false)
            ? SizedBox(
                width: 26,
                height: double.maxFinite,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(child: Icon(icon)),
                    Positioned(
                      top: 8,
                      bottom: 8,
                      left: -4,
                      child: Container(
                        width: 5,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(6),
                            left: Radius.circular(4),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : icon != null
                ? Icon(icon)
                : null,
      ),
    );
  }
}
